<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="id"/>

    <!-- Suppress default text output -->
    <xsl:template match="text()|@*">
    </xsl:template>

    <xsl:template match="/">
        <html>
            <head>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/messages/message/forms/form[@id=$id]">
        <xsl:value-of select="../../body" disable-output-escaping="yes"/>
    </xsl:template>
</xsl:stylesheet>