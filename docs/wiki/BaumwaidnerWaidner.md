---
title: Baumwaidner Waidner
permalink: wiki/BaumwaidnerWaidner/
layout: wiki
---

This paper is referenced by [Asokan Schunter](/SXP/wiki/AsokanSchunter "wikilink")
and [Mukhamedov Ryan](/SXP/wiki/MukhamedovRyan "wikilink"). It is an abuse-free
asynchronous multi-party optimistic contract signing protocols. Say
there are *n* parties:

-   it requires $(n+1)n(n-1)$ messages which may be high;
-   but only $n+2$ rounds which is optimal;
-   in the optimistic case the end signed result is $(C,n+1)$, thus the
    contract $C$ has to specify $n$;
-   but in the pessimistic case the end signed result is $(C,i)$ plus
    some countersigning by $T$.

It uses only standard asymmetric cryptography.

Outline of the protocol
-----------------------

-   Send to $j=1...n$ : $(C,1)\_{Pi}$.
-   Await from $j=1...n$ : $(C,1)\_{Pj}$. Else *resolve*.

For $t=2...n+1$ do:

-   Send to $j=1...n$ : $((C,t-1)\_{P1}...(C,t-1)\_{Pn})\_{Pi},(C,t)\_{Pi}$.
-   Await from $j=1...n$ : $((C,t-1)\_{P1}...(C,t-1)\_{Pn})\_{Pj},(C,t)\_{Pj}$.
    Else *resolve*.

*Resolve* is a subprotocol, where $T$ intervenes, it aims at completing
the protocol by asking $T$ to take a decision whether the contract is
valid and provide a certificate of that. If provided enough grounds for
doing it, $T$ will do so.

