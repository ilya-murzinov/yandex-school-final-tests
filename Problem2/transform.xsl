<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl">
    <xsl:param name="year"/>
    <xsl:param name="sort"/>
    <xsl:param name="order"/>
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
                        <xsl:when test="$artist != ''">
                            <xsl:variable name="tmp" select="exsl:node-set(/audio-database/cd[artist = $artist])"/>
                            <xsl:choose>
                                <xsl:when test="$sort = 'year'">
                                    <xsl:for-each select="$tmp">
                                        <xsl:sort select="year" data-type="number" order="{$order}"/>
                                        <xsl:apply-templates select="."/>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:when test="$sort = 'studio'">
                                    <xsl:for-each select="$tmp">
                                        <xsl:sort select="studio" data-type="text"  order="{$order}"/>
                                        <xsl:apply-templates select="."/>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:when test="$sort = 'title'">
                                    <xsl:for-each select="$tmp">
                                        <xsl:sort select="title" data-type="text" order="{$order}"/>
                                        <xsl:apply-templates select="."/>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each select="$tmp">
                                        <xsl:sort select="artist" data-type="text" order="{$order}"/>
                                        <xsl:apply-templates select="."/>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$year != ''">
                            <xsl:variable name="tmp" select="exsl:node-set(/audio-database/cd[year = $year])"/>
                            <xsl:choose>
                                <xsl:when test="$sort = 'year'">
                                    <xsl:for-each select="$tmp">
                                        <xsl:sort select="year" data-type="number" order="{$order}"/>
                                        <xsl:apply-templates select="."/>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:when test="$sort = 'studio'">
                                    <xsl:for-each select="$tmp">
                                        <xsl:sort select="studio" data-type="text"  order="{$order}"/>
                                        <xsl:apply-templates select="."/>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:when test="$sort = 'title'">
                                    <xsl:for-each select="$tmp">
                                        <xsl:sort select="title" data-type="text" order="{$order}"/>
                                        <xsl:apply-templates select="."/>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each select="$tmp">
                                        <xsl:sort select="artist" data-type="text" order="{$order}"/>
                                        <xsl:apply-templates select="."/>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                    </xsl:choose>
                </table>
            </body>
        </html>
    </xsl:template>

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