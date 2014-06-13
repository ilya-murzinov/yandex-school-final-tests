<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl">
    <xsl:param name="id"/>

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
            <xsl:variable name="message-body-tree" select="exsl:node-set(../../body)"/>
            <xsl:apply-templates select="$message-body-tree/title" mode="inner"/>
            <xsl:apply-templates select="$message-body-tree/section" mode="inner"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="title" mode="inner">
        <h1>
            <xsl:value-of select="."/>
        </h1>
    </xsl:template>

    <xsl:template match="section" mode="inner">
        <h2>
            <xsl:apply-templates select="./paragraph" mode="inner"/>
        </h2>
    </xsl:template>

    <xsl:template match="paragraph" mode="inner">
        <p>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
</xsl:stylesheet>