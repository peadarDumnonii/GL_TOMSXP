package network.impl.tp2p;

import controller.Application;
import network.api.Node;
import java.io.File;
import java.io.IOException;

public class Tp2pNode implements Node{
    private int port;
    private File configFolder;
    boolean initialized = false;

    public Tp2pNode(){ this.port = Application.tomp2pPort; }
    public Tp2pNode(int port){ this.port = port; }


    @Override
    public void initialize(String cacheFolder, String name, boolean persistant) throws IOException{
        File folder = new File("." + System.getProperty("file.separator") + cacheFolder);
        if( ! folder.exists()) {
            folder.mkdir();
        }
        this.configFolder = folder;
        initialized = true;
    }

    @Override
    public boolean isInitialized() {
        return initialized;
    }

    @Override
    public void start(int port) {
        if( !initialized) {
            throw new RuntimeException("Le noeud doit être initialisé avant d'être démarré");
        }
        System.err.println("Noeud démarré sur le port " + port);
        // A compléter

    }

    @Override
    public boolean isStarted() {
        return false;
    }

    @Override
    public void stop() {
        System.err.println("Serveur stoppé");
    }
    public int getPort() { return this.port; }

    // public String getPeerId() {
    //  return this.defaultPeerGroup.getPeerID().toURI().toString();
    //}
}
