---
title: Secure Contract Signing Protocol
permalink: wiki/SecureContractSigningProtocol/
layout: wiki
---

The Secure Contract Signing protocol of [SXP](/SXP/wiki/ "wikilink") is a
[Protocol](/SXP/wiki/Protocols "wikilink").

**Current status: The version 1 protocol is in test.**

Aims of the protocol
--------------------

To allow several parties to sign a contract securely.

What is meant by secure?

-   ***Fairness***. No party should be left having sent his signature on the
    contract; but not having received that of the other parties.
-   ***Timeliness***. At every point any party can decide to leave. If that
    happens either the entire exchange either gets aborted, or can be
    completed without this party.
-   ***Abuse-freeness***. No party is not able produce to an external party
    a proof that the others were willing to sign the contract, which
    she aborted.

Does it rely on a Trusted Third Party (TTP)?

-   With an online TTP this could have been easily done; but this
    protocol also aims at avoiding a costly, central infrastructure.
-   Without any form of TTP this would be impossible to achieve; some
    approximate methods exist, but do not seem that convincing.
-   The protocol relies upon an offline TTP:
    -   when nothing goes wrong the contract gets signed without
        arbitration of the TTP. This is the optimistic case.
    -   when something goes wrong, a claim is sent to the TTP, who then
        steps in to ensure that either everyone, or no one, gets the
        contract signed. This is the non-optimistic case.

Which cryptographic primitive does it rely upon?

-   [Private Contract
    Signatures](/SXP/wiki/PrivateContractSignatures "wikilink").
-   Those are constructed via non-interactive zero-knowledge proofs
    constructions, and based upon the [Decisional
    Diffie-Hellman](http://en.wikipedia.org/wiki/Decisional_Diffie%E2%80%93Hellman_assumption) assumption.

The Protocol
------------

Conventions:

    c is the contract
    P1...Pn are the parties having to sign c
    T is the TTP
    E_Pi(m) is P_i public key encryption on m
    S_Pi(m) is P_i's signature on m
    PCS_Pi(m,Pj,T)  is a private contract signature by party Pi for party Pj on message m than can be opened by T into S_Pi(m)
    Prom_i(k) is (E_P1(PCSPi(c,P1,T)),...,E_Pn(PCS_Pi(c,Pn,T)),E_P1(PCS_Pi((c,k),P1,T)),...,E_Pn(PCS_Pi((c,k),Pn,T)))
       except for Prom_i(n+1) which is S_Pi(c)
    Claim_i(k) is (PCS_P1(c,Pi,T),...,PCS_Pn(c,Pi,T),PCS_P1((c,k),Pi,T),...,PCS_Pn((c,k),Pi,T))
       except for Claim_i(0) which is "I wish to cancel c"
       and Claim_i(n+2) which is (S_P1(c),..,S_Pn(c))
    PossiblyHonestClaims is a list of Claims maintainted by T
    DishonestClaim_i(k) is either (Claim_i(k-1), Claim_j(k')) with k'>k, or (Claim_i(k-1), Claim_i(k')) with k'>k-1
    PossiblyDishonestClaims is a list of DishonestClaims maintainted by T
    HonestyToken is SP_T(PossiblyHonestClaims,DishonestClaims)
    AbortToken is SP_T("Aborted unless all PossiblyHonestsClaims become DishonestClaims", HonestyToken)
    ResolveToken is SP_T(Claim_i(n+2), HonestyToken)
    optimistic is set to true

`Main_i` :

    For k=1...n+2 :  
       broadcast Prom_i(k)  
       i awaits and checks until she forms Claim_i(k)  
       failing that, Resolve_i(k) and _exit_ otherwise you may produce a DishonestClaim_i(k)!
    
`Resolve_i(k)`:

    broadcast E_T(S_Pi(Claim_i(k-1)))  
    i gets either ResolveToken  
    or gets AbortToken  
    _exit_ otherwise you may produce a DishonestClaim_i(k)!
    
`ResolveT`:
    
    Await and check S_Pi(Claim_i(k-1)).  
    % j was dishonest and i shows it  
    If PossiblyHonestClaims has some S_Pj(Claim_i(k')) with k'<k-2, then  
       constitute DishonestClaim_j(k) into DishonestClaims,   
       remove j from PossiblyHonestClaims  
       broadcast HonestyToken  
    % i was dishonest and i shows it  
    If i is in PossiblyHonestClaims or DishonestClaims already, and if this is no duplicate, then  
       constitute DishonestClaim_i(k) into DishonestClaims,   
       remove i from PossiblyHonestClaims,  
       optionally, broadcast HonestyToken   
       exit.  
    %  i was dishonest and j shows it  
    If PossiblyHonestClaims or DishonestClaims has some S_Pj(Claim_i(k')) with k'>k, then  
       constitute DishonestClaim_i(k) into DishonestClaims,   
       remove i from PossiblyHonestClaims,   
       optionally, broadcast HonestyToken  
       exit.  
    % now the claim is possibly honest  
    % intial, claim with promises, wins  
    If (k>1 and PossiblyHonestsClaims is empty) or !optimistic, then  
       set optimistic to false  
       broadcast ResolveToken  
       exit.  
    % initial, claim without nothing, triggers the piling up of all further possibly honest claims with promises, unless these get overturned  
    If (k==1 or PossiblyHonestsClaims is not empty) and optimistic, then  
       add S_Pi(Claim_i(k-1)) to PossiblyHonestsClaims  
       broadcast AbortToken  
       exit.

Why does the protocol accomplishes its aims?
--------------------------------------------

Security proofs of protocols can be rather tricky, and exist at various
degrees of formalization. To understand why this protocol is as it is,
we recommend that the reader goes through our reviews of the directly
related bibliography at the end of this page. Armed with these
intuitions, the reader can then go through the following proof outline.
In case of any doubt of wanting to take this to a higher degree of
formalization, do contact us!

**Proof outline.** First, here is how the security requirements impose
themselves upon the TTP:

-   At round $1&lt;=k&lt;=n+1$ an honest player may send
    $(1&lt;=k&lt;=n+1)$-level promises but never get the other's back, and
    so timeliness demands that he is able to either cancel his
    $(j&lt;=k)$-level promises, or to get his complete set of $(k-1)$-level
    promises opened by the TTP. He does this by sending the TTP a
    resolve request with a complete set of $(k-1)$-level promises.

-   If the TTP initially gets contacted by a player with a resolve
    request showing a complete set of $(k-1&gt;0)$-level promises, then it
    is fair and timely for him to accept to open everything from now on:
    we fall back into the non-optimistic case forever.
-   But if the TTP initially gets contacted by player i with a resolve
    request showing $(k-1=0)$-level promises, i.e. nothing, then by
    fairness the only thing he can do is to accept to cancel the
    player's $(k=1)$-level promises. Then player's claim gets added to the
    $PossiblyHonestsClaims$ list.
-   Say $Player\_i$ sent a complete set of $(k-1&gt;0)$-level promises in a
    resolve request. Later, if the TTP gets contacted by a player with a
    resolve request showing a complete set of $(k'&gt;k+1)$-level
    promises, it may deduce from them that $Player\_i$'s claim was
    dishonest, because is shows that $Player\_i$ has continued beyond
    round k. It follows that $Player\_i$'s claim can be safely removed
    from the $PossiblyHonestsClaims$ list.
-   The same is true if the complete $k'$-level promises got there first,
    or if $Player\_i$ does different requests at different rounds; then
    the $Player\_i$'s claim is dishonest and can safely be ignored.
-   If the TTP gets contacted by $Player\_i$ with a resolve request
    showing $(k-1&gt;0)$-level promises, and it follows from there that
    the $PossiblyHonestsClaims$ list is emptied, then it is fair and
    timely for him to accept to open everything from now on: again we
    fall back into the non-optimistic case forever. This is an overturn.
-   If the TTP gets contacted by $Player\_i$ with a resolve request
    showing $(k-1&gt;0)$-level promises, but it does not follow from there
    that the PossiblyHonestsClaims list is emptied, then by fairness the
    only thing he can do is to accept to cancel the player's
    $k$-level promises. Then that player's claim gets added to the
    $PossiblyHonestsClaims$ list.
-   At round $n+2$ an honest player may send his cleartext signature but
    never get the other's back, and so fairness demands that he is
    always able to get his complete set of $(n+1)$-level promises opened
    by sending a resolve to the TTP. the TTP has to accept this, even if
    this means an overturn: we fall back into the non-optimistic
    case forever.

Second, notice that most these specifications are met just by
construction, i.e. they really describe the TTP's behaviour. Except for
the last two points which seem contradictory... unless it is the case
that complete sets of $(n+1)$-level promises constitute proofs that any
earlier claim is dishonest! This seems to be the only thing we need to
convince ourselves of.

Now, it is clear that a complete set of $(n+1)$-level promises sheds
discredit on all complete set of $(n-1)$-level promises that the TTP may
have received. Hence the only way a possibly honest claim could remain,
is if it is a complete set of $n$-level promises. Similarly, it is clear
this complete set of $n$-level promises had shed discredit on all complete
set of $(n-2)$-level promises that the TTP may have received. Hence the
only way it could not have caused an overturn itself is if there was a
complete set of $(n-1)$-level promises. And so on. Basically for something
wrong to happen at the $(n+2)$-level, there must have been complete sets
of $0...n$-level sent through resolve requests to the TTP, and accepted
for cancellation, i.e. not causing overturns. But this is impossible
because there are only $n$-players, and the TTP is not OK with receiving
two different claims from the same player.

Directly relevant bibliography
------------------------------

[Review of optimistic fair exchange](http://books.google.fr/books?hl=en&lr=&id=DUFqRPNqBrQC&oi=fnd&pg=PA365&dq=%22optimistic+fair%22&ots=HSsEcwYi5v&sig=d4Z6to7fQ06fl-OXlLkQKLIP8Cc\#v=onepage&q=%22optimistic%20fair%22&f=false) by Asokan, Schunter, (2009).
**Reviewed [here](/SXP/wiki/AsokanSchunter "wikilink").** A great entry point to
the topic of secure contract signing.

[Improved multi-party contract
signing](http://www.cs.bham.ac.uk/~mdr/research/papers/pdf/07-fc07.pdf)
by Mukhamedov, Ryan (2007). **Reviewed
[here](/SXP/wiki/MukhamedovRyan "wikilink").** A must read in terms of using PCS,
and in terms of proof structure.

[Round-optimal and abuse-free optimistic multi-party contract
signing](http://www.springerlink.com/content/ruf1079b2vgjmm1m/) by
Baum-Waidner, Waidner (2000). **Reviewed
[here](/SXP/wiki/BaumwaidnerWaidner "wikilink").** A must read in terms of proof
structure and communication structure.

[Abuse-free optimistic contract
signing](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.118.4142)
by Garay, Jakobsson, MacKenzie (1999). **See [Private Contract
Signatures](/SXP/wiki/PrivateContractSignatures "wikilink").**

Related bibliography
--------------------

[An Optimistic Fair Protocol for Aggregate
Exchange](http://ieeexplore.ieee.org/xpl/freeabs_all.jsp?arnumber=5381051)
by Liu (2009). Comment on the usefulness of this paper to the project
[here](/SXP/wiki/Liu "wikilink").

[Payment Scheme for Multi-Party Cascading P2P
Exchange](http://www.springerlink.com/content/408876235155l787/) by Liu,
Zhao, (2007). Comment on the usefulness of this paper to the project
[here](/SXP/wiki/LiuZhao "wikilink").

[Formal Analysis of Multiparty Contract
Signing](http://www.springerlink.com/content/f301555p62357606/) by
Chadha, Kremer, Scedrov (2006). Comment on the usefulness of this thesis
to the project [here](/SXP/wiki/ChadhaKremerScedrov "wikilink").

[An exchange protocol for alternative
currencies](http://ieeexplore.ieee.org/xpl/freeabs_all.jsp?arnumber=1428498)
by Hao, Havey, Turner, (2005). Comment on the usefulness of this paper
to the project [here](/SXP/wiki/HaoHaveyTurner "wikilink").

[An Optimistic Fair Protocol for P2P Chained
Transaction](http://www.springerlink.com/content/72552jg5jk322154/) by
Liu, Fu, Zhang, (2005). Comment on the usefulness of this paper to the
project [here](/SXP/wiki/LiuFuZhang "wikilink").

[A Fair and Reliable P2P E-Commerce Model Based on Collaboration with
Distributed
Peers](http://www.springerlink.com/content/p3543433t71uh2n6/) by Sur,
Jung, Yang, Rhee (2005). Comment on the usefulness of this paper to the
project [here](/SXP/wiki/SurJungYangRhee "wikilink").

[Optimistic Fair Exchange Based on Publicly Verifiable Secret
Sharing](http://www.springerlink.com/content/28b0t21f4e5fhfb9/) by
Avoine, Vaudenay (2004). Comment on the usefulness of this paper to the
project [here](/SXP/wiki/AvoineVaudenay "wikilink").

[Formal Analysis of Optimistic Fair Exchange
Protocols](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.58.9931&rep=rep1&type=pdf)
by Kremer, (2004). Comment on the usefulness of this thesis to the
project [here](/SXP/wiki/Kremer "wikilink").

[Verifiable Encryption of Digital Signatures and
Applications](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.66.4697)
by Ateniese, (2004). For efficient Verifiable Escrows. Comment on the
usefulness of this paper to the project [here](/SXP/wiki/Ateniese "wikilink").

[Trusted computing
platforms.](http://www.hpl.hp.com/techreports/2002/HPL-2002-221.pdf)
Pearson, ed. (2003) Comment on the usefulness of this paper to the
project [here](/SXP/wiki/Pearson "wikilink"). Multi-party abuse-free contract
signing. Asynchronous?

[A multi-party optimistic non-repudiation
protocol](http://www.springerlink.com/content/beq9v0d41wd7g462/) by
Markowitch, Kremer, (2001). Comment on the usefulness of this paper to
the project [here](/SXP/wiki/MarkowitchKremer "wikilink").

[Optimistic Synchronous Multi-Party Contract
Signing](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.20.3562)
by Asokan, Baum-waidner, Schunter , Waidner (1998). Comment on the
usefulness of this paper to the project [here](/SXP/wiki/ABSW98 "wikilink").

[Efficient and practical fair exchange with offline TTP](http://ieeexplore.ieee.org/xpl/login.jsp?tp=&arnumber=674825&url=http%3A%2F%2Fieeexplore.ieee.org%2Fxpls%2Fabs\_all.jsp%3Farnumber%3D674825) by Bao, Deng,
Mao, (1998) Comment on the usefulness of this paper to the project
[here](/SXP/wiki/BaoDengMao "wikilink"). Multi-party abuse-free contract signing.
Asynchronous?

[Opimal efficiency of optimistic contract
signing](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.43.4716)
by Pfitzmann, Schunter, Waidner (1998) Comment on the usefulness of this
paper to the project [here](/SXP/wiki/PfitzmannSchunterWaidner "wikilink").
Communication complexity.

[Fair exchange with a semi-trusted third
party](http://www.cs.unc.edu/~reiter/papers/1997/CCS1.pdf) by Franklin,
Reiter, (1997). Comment on the usefulness of this paper to the project
[here](/SXP/wiki/FranklinReiter "wikilink"). Using peers as TTP.

