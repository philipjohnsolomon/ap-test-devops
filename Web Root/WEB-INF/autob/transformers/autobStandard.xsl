<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../shared/transformers/identityTemplate.xsl" />

    <xsl:template match="//CommlAutoLineBusiness/CommlRateState">
        <xsl:for-each select=".">
            <CommlRateState>
            	<xsl:apply-templates select="@id" />
                <xsl:apply-templates select="NAICCd" />
                <xsl:apply-templates select="StateProvCd" />
                <xsl:apply-templates select="CommlAutoOptionalCoverages" />
                <xsl:apply-templates select="QuestionAnswer" />
                <xsl:apply-templates select="CommlVeh" />
                <xsl:apply-templates select="CommlCoverage" />
                <xsl:apply-templates select="CommlAutoOptionalCoverages/CommlCoverage" />
                <xsl:apply-templates select="CommlAutoPremiumModification/CommlCoverage" />
                <xsl:apply-templates select="WorkCompInd" />
            </CommlRateState>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="CommlAutoOptionalCoverages">
        <xsl:apply-templates select="CommlAutoHiredInfo" />
        <xsl:apply-templates select="CommlAutoNonOwnedInfo" />
        <xsl:apply-templates select="CommlAutoDriveOtherCarInfo" />
    </xsl:template>
    <xsl:template match="CommlAutoPremiumModification">
        <xsl:apply-templates select="CommlCoverage" />
    </xsl:template>

</xsl:stylesheet>
