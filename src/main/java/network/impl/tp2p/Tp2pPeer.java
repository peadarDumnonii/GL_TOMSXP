package network.impl.tp2p;

import controller.tools.LoggerUtilities;
import net.tomp2p.connection.Bindings;
import net.tomp2p.connection.ChannelClientConfiguration;
import net.tomp2p.connection.ChannelServerConfiguration;
import net.tomp2p.connection.Ports;
import net.tomp2p.dht.PeerBuilderDHT;
import net.tomp2p.dht.PeerDHT;
import net.tomp2p.dht.StorageMemory;
import net.tomp2p.futures.FutureBootstrap;
import net.tomp2p.futures.FutureDiscover;
import net.tomp2p.p2p.PeerBuilder;
import net.tomp2p.peers.Number160;
import network.api.Peer;
import network.api.service.InvalidServiceException;
import network.api.service.Service;
import network.impl.tp2p.Tp2pNode;
import network.utils.IpChecker;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Random;

public class Tp2pPeer implements Peer{
    private Tp2pNode node;
    private PeerDHT peerDHT;
    private HashMap<String, Service> services;

    public Tp2pPeer(){
        node = new Tp2pNode();
        services = new HashMap<>();
    }
    public Tp2pPeer(int port){
        node = new Tp2pNode(port);
        services = new HashMap<>();
    }

    @Override
    public void start(String cache, int port, String... ips) throws IOException {
        try {
            createPeer();
        } catch (Exception e) {
            e.printStackTrace();
        }

        node.initialize(cache, "TomSXP_peer", true);
        this.bootstrap(ips);
        node.start(port);
    }

    public void createPeer() throws Exception {
        this.peerDHT = new PeerBuilderDHT(new PeerBuilder(Number160.createHash(IpChecker.getIp())).ports(node.getPort()).start())
                .storage(new StorageMemory(500,5))
                .start();

        if(peerDHT == null) throw new RuntimeException("Erreur lors de la création du peer");
        System.err.println("Création du peer OK, sur le port " + node.getPort() + " , ID = " + peerDHT.peerID());
    }

    @Override
    public void stop() {
        peerDHT.shutdown();
        node.stop();
    }

    @Override
    public String getIp() {
        try {
            return IpChecker.getIp();
        } catch (Exception e) {
            LoggerUtilities.logStackTrace(e);
        }
        return null;
    }

    @Override
    public Collection<Service> getServices() {
        return services.values();
    }

    @Override
    public Service getService(String name) {
        return services.get(name);
    }

    @Override
    public void addService(Service service) throws InvalidServiceException {
        services.put(service.getName(), service);
        // s.setPeerGroup(node.createGroup(service.getName()));
    }

    @Override
    public String getUri() { return peerDHT.peerID().toString(); }

    @Override
    public void bootstrap(String... ips) {
        InetAddress bootstrapAddress;
        for(String ip : ips) {
            System.err.println("Tentative de bootstrap avec : " + ip );
            try{
                bootstrapAddress = InetAddress.getByAddress(ip.getBytes());
                FutureDiscover futureDiscover = peerDHT.peer().discover().inetAddress(bootstrapAddress).ports(node.getPort()).start();
                futureDiscover.awaitUninterruptibly(); // Possibilité de fixer un temps de découverte en mms max

                if (futureDiscover.isSuccess())
                    System.err.println("Découverte OK : adresse du bootsrapper : " + futureDiscover.peerAddress().inetAddress());
                else
                    System.err.println("Problème lors de la découverte : " + futureDiscover.failedReason());

                FutureBootstrap futureBootstrap = peerDHT.peer().bootstrap().inetAddress(bootstrapAddress).ports(node.getPort()).start();
                futureBootstrap.awaitUninterruptibly(); // Possibilité de fixer un temps de bootstrap en mms max

                if (futureBootstrap.isSuccess()) {
                    System.err.println("Bootstrap OK vers " + bootstrapAddress.getHostAddress());
                    break;
                }
                else
                    System.err.println("Erreur lors du bootstrap : " + futureBootstrap.failedReason());
            } catch (UnknownHostException e) {
                LoggerUtilities.logStackTrace(e);
            }
        }
        // regarder networkManager
        // NetworkManager networkManager = node.getNetworkManager();

        // Voir JXTAPeer
    }

    private PeerBuilder preparePeerBuilder(int port) throws Exception {
        String nodeID = IpChecker.getIp();
        ChannelClientConfiguration clientConfig = PeerBuilder.createDefaultChannelClientConfiguration();
        ChannelServerConfiguration serverConfig = PeerBuilder.createDefaultChannelServerConfiguration();

        serverConfig.ports(new Ports(port, port));

        // listen on any interfaces (see https://github.com/Hive2Hive/Hive2Hive/issues/117)
        Bindings bindings = new Bindings().listenAny();

        return new PeerBuilder(Number160.createHash(nodeID)).ports(port).bindings(bindings)
                .channelClientConfiguration(clientConfig).channelServerConfiguration(serverConfig);
    }
}
