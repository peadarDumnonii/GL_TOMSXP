---
title: Mukhamedov Ryan
permalink: wiki/MukhamedovRyan/
layout: wiki
---

Provides abuse-free asynchronous multi-party optimistic contract
signing.

It says that there are only two competitors doing just that:

-   Garay and MacKenzie, whose security has been put at stake.
-   [Baumwaidner Waidner](/SXP/wiki/BaumwaidnerWaidner "wikilink").

Let *n* be the number of parties. This protocol requires *n(n-1)(n/2)+1*
messages. It relies on [Private Contract
Signatures](/SXP/wiki/PrivateContractSignatures "wikilink").

Outline of the protocol
-----------------------

-   Await from $j < i$: $PCS_{Pj}((C,1),Pi,T)$. Else quit.
-   Send to $j > i$: $PCS_{Pi}((C,1),Pj,T)$.
-   Await from $j > i$: $PCS_{Pj}((C,1),Pi,T)$. Else *abort*.
-   Send to $j < i$: $PCS_{Pi}((C,1),Pj,T)$.

For $t=2...n/2$ do:

-   Await from $j < i$: $PCS_{Pj}((C,t),Pi,T)$. Else *resolve*.
-   Send to $j > i$: $PCS_{Pi}((C,t),Pj,T)$.
-   Await from $j > i$: $PCS_{Pj}((C,t),Pi,T)$. Else *resolve*.
-   Send to $j < i$: $PCS_{Pi}((C,t),Pj,T)$.

<!-- -->

-   Await from $j < i$: $PCS_{Pj}((C,n/2+1),Pi,T), {C}_{PrivPj}$.
    Else *resolve*.
-   Send to $j > i$: $PCS_{Pi}((C,n/2+1),Pj,T), {C}_{PrivPi}$.
-   Await from $j > i$: $PCS_{Pj}((C,n/2+1),Pi,T), {C}_{PrivPj}$.
    Else *resolve*.
-   Send to $j < i$: $PCS_{Pi}((C,n/2+1),Pj,T), {C}_{PrivPi}$.

*Abort* is a subprotocol, where $T$ intervenes, it aims at cancelling the
entire protocol by asking $T$ to longer accept to convert some
$PCS_{Pi}((C,t),Pj,T)$ into ${C}_{PrivPi}$. $T$ will either send back a signed
contract or agree to abort. However it may overturn its abort decision
if it realizes that $Pi$ is dishonest.

*Resolve* is a subprotocol, where $T$ intervenes, it aims at completing
the protocol by asking $T$ to convert some $PCS_{Pj}((C,t),Pi,T)$ into
${C}_{PrivPj}$. If provided enough grounds for doing it, $T$ will do so.

See [Asokan Schunter](/SXP/wiki/AsokanSchunter "wikilink") for an intuition on
abort/resolve. See [Chadha Kremer Scedrov](/SXP/wiki/ChadhaKremerScedrov "wikilink")
to understand this messaging structure.

Remarks:

-   The cascading message structure is so that Parties are committed to
    certain stages, e.g. when $P2$ sends its $PCS_{P2}((C,2),P3,T)$, it
    should mean that it has received $PCS_{P1}((C,1),P2,T)$.
-   This information allows the TTP to determine dishonest parties.
-   Colluded dishonest players must not be able to propagate an
    abort decision. The total number of rounds outnumbers the total
    number of abort requests that a coalition of $n-1$ can perform.

Still, we need to build a more thorough intuition of why this works.

