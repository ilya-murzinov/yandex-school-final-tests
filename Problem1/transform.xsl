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

    <xsl:template match="/messages/message/forms/form">
        <xsl:if test="@id = $id">
            <div class="title">
                <xsl:value-of select="../../body/title" disable-output-escaping="yes"/>
            </div>
            <div class="text">
            <xsl:value-of select="../../body/text" disable-output-escaping="yes"/>
            </div>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>