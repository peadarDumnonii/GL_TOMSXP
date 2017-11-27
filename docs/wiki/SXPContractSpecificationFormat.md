---
title: SXP Contract specification format
permalink: wiki/SXPContractSpecificationFormat/
layout: wiki
---

This page describes the technichal information about the SXP Contract
Definition, which is an extension of OASIS Legal XML eContracts.

For validating SXP contracts, users must [download the SXP
Specification](https://docs.google.com/file/d/0B4JKZAq0izyxLVpRd0k5OU0xTDA/edit?usp=sharing)
and the [Legal XML eContracts
Schema](http://docs.oasis-open.org/legalxml-econtracts/CS01/eContracts-v1.0-cs01.zip).
Then, contracts can be validated using a XML validator.

Required clauses
----------------

These are the clauses that the user must fill in for creating a SXP
Contract:

-   **Parties**. We use the *party* element from the
    eContracts Specification. The only changes are:

-   the own element has been set as mandatory (it was optional at
eContracts)

-   the *id* attribute has been set as mandatory as well, so we can refer
to a certain party in future clauses.

Problems:

-   should we extend it by specifying the country of each party, in order
to use this information at the following clauses (see conflict
resolution mode at breachClause?

-   should we constraint more in any way? E.g. forcing the user to fill
*name*, *address*, etc (currently these are optional values at
eContracts).

-   **Breach clause**. A clause that specifies what happens in case of
    one party doesn't accomplish the contract. It has the following
    structure:
    -   Conflict Resolution Mode (mandatory).
        -   exchange-level mode. Conflicts are resolved between the
            parties who needed to exchange items within the contract.
            These are the possibilities:
            -   defendant country. Complaints are presented at the court
                of the defendant party's country
            -   plaintive country. Complaints are presented at the court
                of the plaintitive party's country
            -   fixed country. Complaints are presented at the court of
                a given country
        -   contract-level mode. Even local conflicts are resolved by
            all parties.
    -   Trust Rating Adjustements (optional). Information about the
        adjustements that will be done on the SXP trust rating system.

<!-- -->

-   **SXP Item clause**. We can have an unbounded number of
    *SXPTransfer*, each one representing a single exchange between
    two parties. An SXPTransfer contains the following sequence:
    -   SXP Item. A reference to the [SXP
        Item](/SXP/wiki/SXPItem "wikilink") that will be exchanged.
    -   Party Provider. A unique reference (see xsd:IDREF) to a *party*
        id from above.
    -   Party Receiver.
    -   Delivery instructions. Delivery information associated to the
        previous item:
        -   Date. By when the item will be delivered.
        -   Person responsible. By who the delivery will be made. It may
            be a id reference to a party.
        -   Payer. Who will pay the delivery. It may be a id reference
            to a party.

Optional clauses
----------------

-   **VAT clause**. Information about the value-added taxes involved in
    the exchange.
    -   the amount
    -   the authority who will receive the taxes
    -   the parties responsibles of paying

<!-- -->

-   **Other Clauses**. Basically, users can add as many clauses as they
    want as *items* (do not confuse with the [Items
    Specification](/SXP/wiki/SXPItemSpecificationFormat "wikilink"), which describes
    objects and services), under the *body* level. These clauses are
    intended to contain text that can be read by both parties. These
    particular clauses are original from the Legal XML
    eContracts framework. For more information, see the
    eContracts Specification.

XML Namespace
-------------

Since SXPContract contains a redefinition (`<xs:redefine>`) on the *body*
element from the eContracts schema, we have to keep the same target
namespace from eContracts (`urn:oasis:names:tc:eContracts:1:0`) in our
specification.

Explanation of `<xs:redefine>` : [W3C's XML Schema Part 0: Primer Second
Edition](http://www.w3.org/TR/xmlschema-0/#Redefine)).

Minimal example of a SXP Contract
---------------------------------

In this example, we have two parties (Alice and Bob) exchanging objects
(a laptop and a guitar).

    <?xml version="1.0"?>
    <contract xmlns="urn:oasis:names:tc:eContracts:1:0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:sxp="http://secure-exchange-protocols.org/index.php?title=SXP_Contract"
    xsi:schemaLocation="urn:oasis:names:tc:eContracts:1:0 SXPContract.xsd">  

    <title>
    <text>Contract between Alice and Bob</text>
    
    </title>
     <contract-front>  
       <date-block>`22/1/2013`</date-block>  
       <parties>  
         <party id="aliceID">`Alice`</party>  
         <party id="bobID">`Bob`</party>  
       </parties>  
         
     </contract-front>  
    
    <body>
      <breachClause>  
        <conflictResolutionMode>  
          <exchange-level>  
            <defendantCountry/>  
          </exchange-level>  
        </conflictResolutionMode>  
      </breachClause>  
       
      <SXPItemClause>
    
        <SXPTransfer>  
          
          <SXPItem >  
            <ItemDescription>  
              <Title>
                Guitar
              </Title>
            </ItemDescription>  
            <ItemCategory>  
              <MusicalInstruments/>  
            </ItemCategory>  
          </SXPItem>  
          
          <partyProvider>aliceID</partyProvider>  
          <partyReceiver>bobID</partyReceiver>  
      
          <deliveryInformation>  
            <responsible>Caroline</responsible>  
            <date>2013-04-30</date>  
            <payer><partyRef>aliceID</partyRef></payer>         
          </deliveryInformation>  
    
        </SXPTransfer>
     
        <SXPTransfer>  
          
          <SXPItem >   
            <ItemDescription>  
              <Title>
                Laptop
              </Title>
            </ItemDescription>  
            <ItemCategory>  
              <Computers/>  
            </ItemCategory>  
          </SXPItem>  
           
          <partyProvider>bobID</partyProvider>  
          <partyReceiver>aliceID</partyReceiver>
      
          <deliveryInformation>  
            <responsible>Daniel</responsible>  
            <date>2013-04-25</date>  
            <payer><person-record>Caroline</person-record></payer>  
          </deliveryInformation>  
      
        </SXPTransfer>  
         
      </SXPItemClause>  
         
      <vatClause>  
        <vatAmount> 1.40€ </vatAmount>  
        <responsible><partyRef>bobID</partyRef></responsible>  
        <authority>France Revenue Service</authority>  
      </vatClause>  
       
    </body>
    </contract>

