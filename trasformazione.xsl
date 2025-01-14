<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- Template principale -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Edizione digitale della Rassegna Settimanale</title>
                <link rel="stylesheet" type="text/css" href="styles.css"/>
                <script src="scripts.js"></script>
            </head>
            <body>
                <!-- Informazioni header -->
                <div class="intro">
                    <xsl:apply-templates select="//tei:fileDesc/tei:titleStmt"/>
                    <xsl:apply-templates select="//tei:fileDesc/tei:publicationStmt"/>
                    <xsl:apply-templates select="//tei:fileDesc/tei:seriesStmt"/>
                    <xsl:apply-templates select="//tei:fileDesc/tei:sourceDesc"/>
                </div>

                <!-- Navigazione -->
                <nav>
                    <ul id="annotation-menu" class="menu">
                        <li><button data-type="person">Persone</button></li>
                        <li><button data-type="place">Luoghi</button></li>
                        <li><button data-type="role">Ruoli</button></li>
                        <li><button data-type="title">Opere</button></li>
                        <li><button data-type="org">Organizzazioni</button></li>
                        <li><button data-type="foreign">Testo straniero</button></li>
                        <li><button data-type="quote">Citazioni</button></li>
                        <li><button data-type="date">Date</button></li>
                        <li><button data-type="num">Numeri</button></li>
                        <li><button data-type="measure">Misure</button></li>
                        <li><button data-type="verbum">Verbum</button></li>
                        <li><button data-type="distinct">Varianti linguistiche</button></li>
                        <li><button id="toggle-abbr">Espansioni</button></li>
                        <li><button id="toggle-orig">Regolarizzazioni</button></li>
                        <li><button id="toggle-sic">Correzioni</button></li>
                    </ul>
                    <ul id="theme_menu" class="menu">
                        <li><button data-type="nature">Natura</button></li>
                        <li><button data-type="infrastrutture">Infrastrutture</button></li>
                        <li><button data-type="pubblica_amministrazione">Pubblica Amministrazione</button></li>
                        <li><button data-type="law">Leggi</button></li>
                        <li><button data-type="event">Eventi</button></li>
                        <li><button data-type="art">Arte</button></li>
                        <li><button data-type="education">Istruzione</button></li>
                        <li><button data-type="math">Matematica</button></li>
                        <li><button data-type="verismo">Verismo</button></li>
                    </ul>
                    <button id="toggle-navbar" class="toggle-btn">&#11167;</button>
                </nav>

                <div class="tuttiarticoli">
                     <xsl:apply-templates select="//tei:body/tei:div"/>
                </div>

                <!-- Appendice -->
                <xsl:apply-templates select="//tei:back"/>

                <!--Footer-->
                <footer>
                    <span>Per consultare altro matariale d'archivio visita il <a href="https://rassegnasettimanale.animi.it/">sito ufficiale della rivista</a></span>
                    <img  src="img/logo_unipi.jpg" alt="logo_rassegna"/>
                    <div>©
                      <xsl:value-of select="//tei:publicationStmt/tei:date"/>, <xsl:value-of select="//tei:publisher"/>
                    </div>
                </footer>
            </body>
        </html>
    </xsl:template>

    <!-- Template per titleStmt -->
    <xsl:template match="tei:titleStmt">
    <h1 class="titolo"><xsl:value-of select="normalize-space(tei:title)"/></h1>
    <h2 class="sottotitolo">
        <xsl:value-of select="tei:respStmt/tei:resp"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space(tei:respStmt/tei:name[1])"/>
        <xsl:text> e </xsl:text>
        <xsl:value-of select="normalize-space(tei:respStmt/tei:name[2])"/>
    </h2>
    </xsl:template>


    <!-- Template per publicationStmt -->
    <xsl:template match="tei:publicationStmt">
    <div class="pubblicazione card">
        <h3>Pubblicazione</h3>
        <strong>Editore: </strong><xsl:value-of select="tei:publisher"/> <br/>
        <strong>Luogo e data: </strong><xsl:value-of select="tei:pubPlace"/>, <xsl:value-of select="tei:date"/> <br/>
        <strong>Indirizzo: </strong><xsl:value-of select="tei:address/tei:street"/>
    </div>
    </xsl:template>

    <!-- Template per publicationStmt -->
    <xsl:template match="tei:seriesStmt">
    <div class="serie card">
        <h3>Serie</h3>
        <xsl:value-of select="tei:title"/> <br/>
        <xsl:value-of select="tei:respStmt/tei:resp"/><xsl:text> </xsl:text>
        <xsl:value-of select="tei:respStmt/tei:name"/>
    </div>
    </xsl:template>

    <xsl:template match="tei:sourceDesc">
    <div class="info_generali card">
        <h3>Fonte</h3>
        <strong>Titolo della monografia:</strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:title"/><br/>
        <strong>Lingua della monografia:</strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:textLang"/><br/>
        <strong>Responsabili:</strong>
        <xsl:for-each select="tei:biblStruct/tei:monogr/tei:respStmt/tei:name">
            <xsl:value-of select="."/>
            <xsl:if test="position() != last()">, </xsl:if>
        </xsl:for-each>
        <br/>
        <strong>Pubblicazione:</strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:pubPlace"/>,
        <xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:date"/><br/>
        <strong>Editore:</strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:publisher"/><br/>
        <strong>Volumi:</strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[@unit='volume']"/><br/>
        <strong>Fascicoli:</strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[@unit='issue']"/><br/>
        <strong>Pagine:</strong> <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[@unit='page']"/><br/>
        
        <h3>Articoli</h3>
        <xsl:for-each select="tei:biblStruct/tei:analytic">
            <br/><xsl:value-of select="tei:title"/><br/>
        </xsl:for-each>
    </div>
    </xsl:template>

    <!-- Template per gli head degli articoli -->
    <!-- Template per il primo head della bibliografia -->
    <xsl:template match="tei:div[@type='bibliografia']/tei:head[1]">
    <h3 class="highlight" id="{@xml:id}">
            <xsl:if test="@rend">
                    <xsl:apply-templates select="@rend"/>
            </xsl:if>
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

    <!-- Template per il secondo head della bibliografia -->
    <xsl:template match="tei:div[@type='bibliografia']/tei:head[2]">
    <h4 class="highlight" id="{@xml:id}">
            <xsl:if test="@rend">
                    <xsl:apply-templates select="@rend"/>
            </xsl:if>
            <xsl:apply-templates/>
        </h4>
    </xsl:template>

    <!-- Template per i div poem -->
    <xsl:template match="tei:div[@type='poem']/tei:head">
    <h4 class="highlight" id="{@xml:id}">
            <xsl:if test="@rend">
                    <xsl:apply-templates select="@rend"/>
            </xsl:if>
            <xsl:apply-templates/>
        </h4>
    </xsl:template>

    <xsl:template match="tei:div[@type='article']/tei:head">
    <h3 class="highlight" id="{@xml:id}">
            <xsl:if test="@rend">
                <xsl:apply-templates select="@rend"/>
            </xsl:if>
            <xsl:apply-templates/></h3> 
    </xsl:template>

    <xsl:template match="tei:ab">
        <div class="ab">
        <h3 id="{@xml:id}" class="highlight">
                <xsl:apply-templates/>
        </h3>
        </div>
    
    </xsl:template>

    <!-- Template per surface -->
    <xsl:template match="tei:surface">
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:value-of select="tei:graphic/@url" />
            </xsl:attribute>
            <xsl:attribute name="usemap">#<xsl:value-of select="@xml:id" /></xsl:attribute>
            <xsl:attribute name="alt">Immagine <xsl:value-of select="@xml:id" /></xsl:attribute>
            <xsl:attribute name="class">facsimile</xsl:attribute>
        </xsl:element>
        <xsl:element name="map">
            <xsl:attribute name="name">
                <xsl:value-of select="@xml:id" />
            </xsl:attribute>
            <xsl:for-each select="tei:zone">
                <xsl:element name="area">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id" />
                    </xsl:attribute>
                    <xsl:attribute name="coords">
                        <xsl:value-of select="@ulx" />,<xsl:value-of select="@uly" />,<xsl:value-of select="@lrx" />,<xsl:value-of select="@lry" />
                    </xsl:attribute>
                    <xsl:attribute name="data-corresp">
                        <xsl:value-of select="@corresp" />
                    </xsl:attribute>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:div[@type='article' or @type='bibliografia']">
    <!-- Apertura div con class pagina e contenuto per tutti i tipi -->
    <div class="pagina">
        <div class="contenuto">
            <div class="colonna">
                <xsl:apply-templates/>
            </div>
        </div>
    </div>
    </xsl:template>

    <xsl:template match="tei:pb">

    <!-- Stampa chiusura del div colonna -->
            <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>

            <!-- Stampa chiusura del div contenuto -->
            <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>

            <!-- Stampa chiusura del div pagina -->
            <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>

            <!-- Stampa apertura del div pagina -->
            <xsl:text disable-output-escaping="yes">&lt;div class="pagina" id="</xsl:text>
            <xsl:value-of select="@facs"/>
            <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>

            <!-- Immagine -->
            <div class="facsimile">
                <xsl:variable name="facs_id" select="substring-after(@facs, '#')"/>
                <xsl:apply-templates select="//tei:facsimile/tei:surface[@xml:id=$facs_id]"/>
            </div>

            <!-- Stampa apertura del div contenuto -->
            <xsl:text disable-output-escaping="yes">&lt;div class="contenuto" id="</xsl:text>
            <xsl:value-of select="@xml:id"/>
            <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>

            <!-- Stampa apertura del div colonna -->
            <xsl:text disable-output-escaping="yes">&lt;div class="colonna"&gt;</xsl:text>

    </xsl:template>

    <xsl:template match="tei:cb">
        <xsl:text disable-output-escaping="yes">&lt;/div&gt;&lt;div class="colonna"&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:lb">
        <br/>
        <span id="{@xml:id}" class="highlight">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Template per versi -->
    <xsl:template match="tei:l">
        <div class="verso highlight" id="{@xml:id}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<!-- Template per persName -->
    <xsl:template match="tei:persName">
            <span class="person">
                <xsl:if test="@rend">
                <xsl:apply-templates select="@rend"/>
                </xsl:if>
                <xsl:choose>
                <xsl:when test="ancestor::tei:title">
                    <!-- Se è dentro un title, non creare il link -->
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="@ref">
                    <!-- Se non è dentro un title e ha @ref, crea il link -->
                    <a href="{@ref}"><xsl:apply-templates/></a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
                </xsl:choose>
            </span>
    </xsl:template>

    <!-- Template per luoghi -->
    <xsl:template match="tei:placeName">
        <span class="place">
            <xsl:if test="@rend">
                <xsl:apply-templates select="@rend"/>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="@ref">
                    <a href="{@ref}"><xsl:apply-templates/></a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="tei:hi">
        <span class="hi">
            <xsl:if test="@rend">
                <xsl:apply-templates select="@rend"/>
            </xsl:if>
                <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Template per organizzazioni -->
    <xsl:template match="tei:orgName">
        <span class="org">
            <xsl:if test="@rend">
                <xsl:apply-templates select="@rend"/>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="@ref">
                    <a href="{@ref}"><xsl:apply-templates/></a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <!-- Template per titoli -->
    <xsl:template match="tei:title">
        <span class="title">
            <xsl:if test="@rend">
            <xsl:apply-templates select="@rend"/>
            </xsl:if>
            <xsl:choose>
            <xsl:when test="@ref">
                <a href="{@ref}"><xsl:apply-templates/></a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

<!-- Template per roleName -->
    <xsl:template match="tei:roleName">
        <span class="role">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Template per il testo straniero -->
    <xsl:template match="tei:foreign">
        <span class="foreign" lang="{@xml:lang}">
            <xsl:if test="@rend">
                <xsl:apply-templates select="@rend"/>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:note">
        <span id="{@xml:id}" class="nota highlight">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:closer">
        <div id="{@xml:id}" class="closer highlight">
            <xsl:apply-templates select="tei:signed/@rend"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:distinct">
        <span class="distinct {@time}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

<!-- Template generico per tei:term con qualsiasi @type -->
    <xsl:template match="tei:term[@type]">
        <span class="{@type}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:measure">
        <span class="measure">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    
    <!-- Template per term[@type='event'] e eventName -->
    <xsl:template match="tei:eventName">
        <span class="event">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Template per quote -->
    <xsl:template match="tei:quote">
        <span class="quote">
            <xsl:if test="@rend">
                <xsl:apply-templates select="@rend"/>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Template per tei:verbum -->
    <xsl:template match="tei:verbum">
        <span class="verbum">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Template per tei:date -->
    <xsl:template match="tei:date">
        <span class="date">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Template per tei:num -->
    <xsl:template match="tei:num">
        <span class="num">
            <xsl:if test="@rend">
                <xsl:apply-templates select="@rend"/>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:choice">
        <!-- abbr/expan -->
        <xsl:if test="tei:abbr and tei:expan">
            <span class="choice">
                <span class="abbr">
                    <xsl:apply-templates select="tei:abbr"/>
                </span>
                <span class="expan">
                    <xsl:apply-templates select="tei:expan"/>
                </span>
            </span>
        </xsl:if>
        
        <!-- orig/reg -->
        <xsl:if test="tei:orig and tei:reg">
            <span class="choice">
                <span class="orig">
                    <xsl:apply-templates select="tei:orig"/>
                </span>
                <span class="reg">
                    <xsl:apply-templates select="tei:reg"/>
                </span>
            </span>
        </xsl:if>
        
        <!-- sic/corr -->
        <xsl:if test="tei:sic and tei:corr">
            <span class="choice">
                <span class="sic">
                    <xsl:apply-templates select="tei:sic"/>
                </span>
                <span class="corr">
                    <xsl:apply-templates select="tei:corr"/>
                </span>
            </span>
        </xsl:if>
    </xsl:template>

    <!-- Template per back -->
    <xsl:template match="tei:back">
        <div class="appendix">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Template per tutti gli head -->
    <xsl:template match="tei:listPerson|tei:listOrg|tei:listPlace|tei:listEvent|tei:listBibl">
        <div class="appendix_box" id="{local-name()}">
            <h3>
                <xsl:value-of select="tei:head"/>
            </h3>
            <xsl:apply-templates select="tei:head/following-sibling::*"/>
        </div>
    </xsl:template>

    <!-- Template per person -->
    <xsl:template match="tei:person">
        <div class="appendice person_box">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <h4>
                <a href="{tei:persName/tei:ref/@target}">
                    <xsl:value-of select="tei:persName/tei:forename"/>
                    <xsl:if test="tei:persName/tei:surname">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="tei:persName/tei:surname"/>
                    </xsl:if>
                    <xsl:if test="tei:persName/tei:addName">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="tei:persName/tei:addName"/>
                    </xsl:if>
                    <xsl:if test="tei:persName/tei:roleName">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="tei:persName/tei:roleName"/>
                    </xsl:if>
                </a>
         </h4>

            <!-- Gestione nascita -->
            <xsl:if test="tei:birth">
                <span>Data di nascita: </span>
                <xsl:value-of select="tei:birth/tei:date"/>
                <br/>
            </xsl:if>
            <!-- Gestione morte -->
            <xsl:if test="tei:death">
                <span>Data di morte: </span>
                <xsl:value-of select="tei:death/tei:date"/>
                <br/>
            </xsl:if>
            <!-- Gestione occupazione -->
            <xsl:if test="tei:occupation">
                <span>Occupazione: </span>
                <xsl:value-of select="tei:occupation"/>
            </xsl:if>
        </div>
    </xsl:template>

    <!-- Template per org -->
    <xsl:template match="tei:org">
        <div class="appendice org_box">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>

            <h4>
                <a href="{tei:orgName/tei:ref/@target}">
                    <xsl:value-of select="tei:orgName"/>
                </a>
            </h4>

          <xsl:if test="tei:state/@from">
                <span>Periodo:</span> <xsl:text> dal </xsl:text>
                <xsl:if test="tei:state/@from">
                    <xsl:value-of select="tei:state/@from"/>
                </xsl:if>
                <xsl:if test="tei:state/@from and tei:state/@to">
                    <xsl:text> al </xsl:text>
                    <xsl:value-of select="tei:state/@to"/>
                </xsl:if>
            </xsl:if>

        </div>
    </xsl:template>

    <!-- Template per place -->
   <xsl:template match="tei:place">
        <div class="appendice place_box">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            
            <h4>
                <xsl:value-of select="tei:placeName"/>
            </h4>
            
            <xsl:if test="tei:location">
                <span>Situato in: </span>
                <!-- Gestione bloc -->
                <xsl:if test="tei:location/tei:bloc">
                    <xsl:value-of select="tei:location/tei:bloc"/>
                    <xsl:if test="tei:location/tei:country or tei:location/tei:settlement">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:if>
                <!-- Gestione country -->
                <xsl:if test="tei:location/tei:country">
                    <xsl:value-of select="tei:location/tei:country"/>
                    <xsl:if test="tei:location/tei:settlement">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:if>
                <!-- Gestione settlement -->
                <xsl:if test="tei:location/tei:settlement">
                    <xsl:value-of select="tei:location/tei:settlement"/>
                </xsl:if>
                <br/>
            </xsl:if>
            
            <!-- Gestione note -->
            <xsl:if test="tei:note">
                    <div class="note">
                        <xsl:for-each select="tei:note/node()">
                            <xsl:choose>
                                <xsl:when test="self::text()">
                                    <xsl:value-of select="."/>
                                </xsl:when>
                                <xsl:when test="self::tei:placeName">
                                    <xsl:value-of select="."/>
                                </xsl:when>
                                <xsl:when test="self::tei:ref">
                                    <br/>
                                    <a href="{@target}">
                                        <xsl:value-of select="text()"/>
                                    </a>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                    </div>
             </xsl:if>
        </div>
    </xsl:template>

    <!-- Template per event -->
      <xsl:template match="tei:event">
        <div class="appendice event_box">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            
            <h4>
                    <a href="{@ref}">
                        <xsl:value-of select="tei:eventName"/>
                    </a>
            </h4>
            
            <!-- Date -->
            <xsl:if test="@from">
                <span>Periodo: </span>
                <xsl:text> dal </xsl:text>
                <xsl:value-of select="@from"/>
    
                <xsl:if test="@from and @to">
                    <xsl:text> al </xsl:text>
                    <xsl:value-of select="@to"/>
                </xsl:if>
            </xsl:if>
            
        </div>
    </xsl:template>

    <!-- Template per bibl -->
    <xsl:template match="tei:listBibl/tei:bibl">
        <div class="appendice bibl_box">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>

            <h4>
                <a href="{tei:ref/@target}">
                    <xsl:value-of select="tei:title"/>
                </a>
            </h4>

            <!-- Autore -->
            <xsl:if test="tei:author">
                <span>Autore: </span>
                <xsl:value-of select="tei:author"/>
                <br/>
            </xsl:if>
            <!-- Editore -->
            <xsl:if test="tei:editor">
                <span>Editore: </span>
                <xsl:value-of select="tei:editor"/>
                <br/>
            </xsl:if>
            <!-- Data -->
            <xsl:if test="tei:date">
                <span>Data: </span>
                <xsl:value-of select="tei:date"/>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="@rend">
        <xsl:attribute name="style">
            <xsl:if test="contains(., 'align(right)')">
                <xsl:text>text-align: right; </xsl:text>
            </xsl:if>
            <xsl:if test="contains(., 'align(center)')">
                <xsl:text>text-align: center; </xsl:text>
            </xsl:if>
            <xsl:if test="contains(., 'case(allcaps)')">
                <xsl:text>text-transform: uppercase; </xsl:text>
            </xsl:if>
            <xsl:if test="contains(., 'case(smallcaps)')">
                <xsl:text>font-variant: small-caps; </xsl:text>
            </xsl:if>
            <xsl:if test="contains(., 'italic')">
                <xsl:text>font-style: italic; </xsl:text>
            </xsl:if>
        </xsl:attribute>
    </xsl:template>

</xsl:stylesheet>