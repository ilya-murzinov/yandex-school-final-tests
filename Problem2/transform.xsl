<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl">
    <xsl:output method="html" indent="yes"/>

    <xsl:param name="year"/>
    <xsl:param name="sort">artist</xsl:param>
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
            </body>
            <table border="1px solid">
                <tr>
                    <td>Title:</td>
                    <td>Artist:</td>
                    <td>Year:</td>
                    <td>Tracks:</td>
                    <td>Studio:</td>
                    <td>Cover:</td>
                </tr>
                <xsl:call-template name="sort"/>
            </table>
        </html>
    </xsl:template>

    <xsl:template name="sort">
        <xsl:variable name="tmp"
                      select="/audio-database/cd[(year = $year or $year = '')
                      and (artist = $artist or $artist = '')]"/>
        <xsl:choose>
            <xsl:when test="$sort = 'year'">
                <xsl:apply-templates select="$tmp">
                    <xsl:sort select="*[name() = $sort]" data-type="number" order="{$order}"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="$tmp">
                    <xsl:sort select="*[name() = $sort]" data-type="text" order="{$order}"/>
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
            <td><xsl:apply-templates select="tracks/track"/></td>
            <td><xsl:value-of select="studio"/></td>
            <td><xsl:value-of select="cover"/></td>
        </tr>
    </xsl:template>

    <xsl:template match="track">
        <xsl:value-of select="@title"/>
        <xsl:text>; </xsl:text>
    </xsl:template>

</xsl:stylesheet>