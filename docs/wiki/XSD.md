---
title: XSD
permalink: wiki/XSD/
layout: wiki
---

XML Schema Definition is a schema language that allow users to define
XML structures. It has become a W3C recommendation.

Referencing a XML Schema
------------------------

When we have an XML document whose structure conforms to a given
structure, we may want to reference to the XSD document where that
structure is located. This is done with the *schemaLocation* attribute
at the root element. Here is an example of how this works on the
[SXP Contract](/SXP/wiki/SXPContract "wikilink") Schema:

    <?xml version="1.0"?>
    <contract xmlns="[http://www.w3schools.com](http://www.w3schools.com)"  
    xmlns:xsi="[http://www.w3.org/2001/XMLSchema-instance](http://www.w3.org/2001/XMLSchema-instance)"  
    **xsi:schemaLocation**="[urn:oasis:names:tc:eContracts:1:0](urn:oasis:names:tc:eContracts:1:0) SXPContract.xsd">

This attribute has two values, separated by a space. The first value is
the namespace to use. The second value is the location of the XML schema
to use for that namespace.

The namespace from *schemaLocation* has to be the same as the one on the
XSD document under the attribute *targetNamespace*. Certainly, on
SXPContract.xsd we have:

    <?xml version="1.0" encoding="UTF-8"?>
    <xs:schema
    ...
    targetNamespace="urn:oasis:names:tc:eContracts:1:0">

More information on this: [W3Schools: the schema
element](http://www.w3schools.com/schema/schema_schema.asp)

