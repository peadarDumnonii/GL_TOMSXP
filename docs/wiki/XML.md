---
title: XML
permalink: wiki/XML/
layout: wiki
tags:
 - Technical Glossary
---

What is XML?
------------

XML is a tunable tag language for describing things in a hierarchical,
formatted manner. For instance HTML, the language of all webpages, is a
tuned version of XML.

XML is not particularly elegant, but it has become a standard. As a
consequence:

-   there are many tools around for manipulating XML.
-   there may already by some tuned versions of XML for specifying
    [items](/SXP/wiki/SXPItemSpecificationFormat "wikilink") and
    [contracts](/SXP/wiki/ContractsSpecification "wikilink"), which is what
    we want.
-   once GUIs will be developed none will have to see the
    underlying XML.

Basic Structure
---------------

-   **Tags**. The information in an XML file is stored inside tags. Tags
    are not predefined in XML: users must define their own ones.

<!-- -->

-   **Elements**. An XML element is everything from (including) the
    element's start tag to (including) the element's end tag.

<!-- -->

-   **Attributes**. An attribute is some extra information, provided at
    the start tag in quotation marks. They are intended to be metadata
    (data about data).

Here is an example of an .xml file:

    <?xml version="1.0" encoding="ISO-8859-1"?>
    <note id=“1245”>
      <to>Tove</to>  
      <from>Jani</from>  
      <heading>Reminder</heading>  
      
      <body>
        Don't forget me this weekend!
      </body>
    </note>

In the example, *note* is an element and *id* is an attribute.

Defining XML structures
-----------------------

In XML, it is possible to define structures. Then, we can verify if a
given xml file matches with this structure. For example, we can define a
*Contract* and verify that a given file created by a user has a valid
structure, according to the file that we have defined. We call this
proccess *Validation*.

This definitions are made in external files. There are different
documents to accomplish that:

-   DTD (Document Type Definition).
-   [XSD](/SXP/wiki/XSD "wikilink") (XML Schemas). Schemas are the most used way to the define a
    XML structure. The [SXP Contract](/SXP/wiki/SXPContract "wikilink") schema is
    an XSD.
-   Relax NG files.

XML Namespaces
--------------

In XML, it is possible to define namespaces in order to distinguish the
authorship of the different tags.

Normalization organisms
-----------------------

There are many organisms that define protocols, schemas based on XML.
Here there are some of the most importants:

-   W3C. International consortium that produces standards for the world
    wide web. They defined XML specification in the first place.
-   ISO. Organization that promotes worldwide proprietary, industrial,
    and commercial standards.
-   OASIS. Global consortium that drives the development, convergence,
    and adoption of e-business and web service standards.
-   IANA.

More content of XML
-------------------

Here are the obvious pages about XML:

-   [on Wikipedia](http://en.wikipedia.org/wiki/XML%7CXML)
-   [XML tutorial at w3schools](http://www.w3schools.com/xml/)

Generating PDFs from XML
------------------------

See [XML tools](/SXP/wiki/XMLTools "wikilink").

