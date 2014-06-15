<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl">
    <xsl:param name="id"/>
    <xsl:output method="html" indent="yes"/>

    <!-- Suppress default text output -->
    <xsl:template match="text()|@*">
    </xsl:template>

    <xsl:template match="/">
        <div class="message">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="/messages/message">
        <xsl:if test="forms/form/@id = $id">
            <div class="title">
                <xsl:value-of select="body/title" disable-output-escaping="yes"/>
            </div>
            <div class="text">
                <xsl:apply-templates select="body/text/paragraph"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="paragraph">
        <div class="paragraph">
            <xsl:value-of select="." disable-output-escaping="yes"/>
        </div>
    </xsl:template>

</xsl:stylesheet>