<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dyn="http://exslt.org/dynamic"
                xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl dyn">
    <xsl:param name="year"/>
    <xsl:param name="sort"/>
    <xsl:param name="order">ascending</xsl:param>
    <xsl:param name="artist"/>

    <!-- Suppress default text output -->
    <xsl:template match="text()|@*">
    </xsl:template>

    <xsl:template match="/">
        <html>
            <head>
            </head>
            <body>
                <table border="1px solid">
                    <xsl:choose>
                        <xsl:when test="$sort = 'year'">
                            <xsl:call-template name="sort">
                                <xsl:with-param name="type" select="'number'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="sort">
                                <xsl:with-param name="type" select="'text'"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="sort">
        <xsl:param name="type"/>
        <xsl:choose>
            <xsl:when test="$artist != ''">
                <xsl:variable name="tmp" select="exsl:node-set(/audio-database/cd[artist = $artist])"/>
                <xsl:apply-templates select="$tmp">
                    <xsl:sort select="*[name() = $sort]" data-type="{$type}" order="{$order}"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$year != ''">
                <xsl:variable name="tmp" select="exsl:node-set(/audio-database/cd[year = $year])"/>
                <xsl:apply-templates select="$tmp">
                    <xsl:sort select="*[name() = $sort]" data-type="{$type}" order="{$order}"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="/audio-database/cd">
                    <xsl:sort select="*[name() = $sort]" data-type="{$type}" order="{$order}"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--This is used to display result-->
    <xsl:template match="cd">
        <tr>
            <td><xsl:value-of select="title"/></td>
            <td><xsl:value-of select="artist"/></td>
            <td><xsl:value-of select="year"/></td>
            <td><xsl:value-of select="studio"/></td>
            <td><xsl:value-of select="cover"/></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>