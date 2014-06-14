<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>

    <!-- Suppress default text output -->
    <xsl:template match="text()|@*">
    </xsl:template>

    <xsl:template match="/">
        <html>
            <head>
                <meta charset="utf-8"/>
            </head>
            <body>
                <script src="http://code.jquery.com/jquery-2.1.1.min.js"/>
                <script src="scripts.js"/>
                <form name="form" method="get" onSubmit="return validate();">
                    <fieldset>
                        <xsl:apply-templates/>
                    </fieldset>
                    <input type="submit"/>
                </form>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="input">
        <p>
            <label>
                <xsl:value-of select="@label"/>
            </label>
            <input>
                <xsl:attribute name="name">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
                <xsl:attribute name="type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
                <xsl:if test="@type = 'number'">
                    <xsl:attribute name="min">
                        <xsl:value-of select="@min"/>
                    </xsl:attribute>
                    <xsl:attribute name="max">
                        <xsl:value-of select="@max"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@type = 'text'">
                    <xsl:attribute name="max-length">
                        <xsl:value-of select="@max-length"/>
                    </xsl:attribute>
                    <xsl:attribute name="regexp">
                        <xsl:value-of select="@regexp"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@required = 'true'">
                    <xsl:attribute name="required"/>
                </xsl:if>
                <xsl:attribute name="value">
                    <xsl:value-of select="@default"/>
                </xsl:attribute>
            </input>
        </p>
    </xsl:template>

</xsl:stylesheet>