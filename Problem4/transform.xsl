<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl">
    <xsl:output method="html" indent="yes" encoding="utf-8"/>

    <!-- Suppress default text output -->
    <xsl:template match="text()|@*">
    </xsl:template>

    <xsl:template match="/">
        <xsl:variable name="node-set">
            <xsl:apply-templates select="root/project/page"/>
        </xsl:variable>
        <xsl:call-template name="create-menu">
            <xsl:with-param name="menu" select="exsl:node-set($node-set)"/>
        </xsl:call-template>
    </xsl:template>

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

    <xsl:template match="page">
        <item>
            <title>
                <xsl:value-of select="@name"/>
            </title>
            <url>
                <xsl:value-of select="."/>
            </url>
        </item>
    </xsl:template>

    <xsl:template match="item">
        <div class="menu-item">
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="./url"/>
                </xsl:attribute>
                <xsl:value-of select="./title"/>
            </a>
        </div>
    </xsl:template>

</xsl:stylesheet>