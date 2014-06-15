<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl">
    <xsl:output method="html" indent="yes" encoding="utf-8"/>

    <!-- Suppress default text output -->
    <xsl:template match="text()|@*">
    </xsl:template>

    <xsl:template match="/">
        <xsl:variable name="node-set">
            <xsl:variable name="current" select="/root/request/url/text()"/>
            <xsl:apply-templates select="root/project/page">
                <xsl:with-param name="current" select="$current"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:call-template name="create-menu">
            <xsl:with-param name="menu" select="exsl:node-set($node-set)"/>
        </xsl:call-template>
    </xsl:template>

    <!--
        Generate menu presentation from node-set.
    -->
    <xsl:template name="create-menu">
        <xsl:param name="menu"/>
        <html>
            <head>
            </head>
            <body>
                <div class="menu">
                    <xsl:apply-templates select="$menu/item"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <!--
        Transform "page" element into "item" element.
    -->
    <xsl:template match="page">
        <xsl:param name="current"/>
        <item>
            <xsl:if test="$current = .">
                <xsl:attribute name="is-current">
                    <xsl:value-of select="string(true())"/>
                </xsl:attribute>
            </xsl:if>

            <title>
                <xsl:value-of select="@name"/>
            </title>
            <url>
                <xsl:value-of select="."/>
            </url>
        </item>
    </xsl:template>

    <!--
        Transform "item" element into

        <div class="menu-item">
        <a href="item/url">item/name</a>
        </div>
    -->
    <xsl:template match="item">
        <div class="menu-item">
            <xsl:if test="./@is-current=false()">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="./url"/>
                    </xsl:attribute>
                    <xsl:value-of select="./title"/>
                </a>
            </xsl:if>
            <xsl:if test="./@is-current=true()">
                <xsl:value-of select="./title"/>
            </xsl:if>
        </div>
    </xsl:template>

</xsl:stylesheet>