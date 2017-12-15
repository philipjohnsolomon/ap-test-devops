<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:func="http://exslt.org/functions" xmlns:ap="http://agencyport.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:uuid="xalan://java.util.UUID">
    <xsl:output method="xml" />
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>

    <!-- second variable -->
    <func:function name="ap:hasPremiumModificationCoverages">
        <xsl:param name="rateStateElement" />
        <xsl:choose>
            <xsl:when test="$rateStateElement/CommlCoverage[CoverageCd='LIEXP' or CoverageCd='PDEXP' or CoverageCd='LISCH' or CoverageCd='PDSCH']">
                <func:result select="true()" />
            </xsl:when>
            <xsl:otherwise>
                <func:result select="false()" />
            </xsl:otherwise>
        </xsl:choose>
    </func:function>

    <!-- first variable -->
    <func:function name="ap:hasOptionalCoverages">
        <xsl:param name="rateStateElement" />
        <xsl:choose>
            <xsl:when test="count(CommlAutoHiredInfo) &gt; 0 or
						count(CommlAutoNonOwnedInfo) &gt; 0 or
						count(CommlAutoDriveOtherCarInfo) &gt; 0">
                <func:result select="true()" />
            </xsl:when>
            <xsl:when test="$rateStateElement/CommlCoverage[contains('CSL:BISPL:OPTBI:PERIL:LUSE:BPIP:LPD:GOVT:AHIPH:NOWND:HRDBD:DOC:PD', CoverageCd)]">
                <func:result select="true()" />
            </xsl:when>
            <xsl:otherwise>
                <func:result select="false()" />
            </xsl:otherwise>
        </xsl:choose>
    </func:function>

    <!-- Look for certain coverages -->
    <func:function name="ap:isPremiumModificationCoverage">
        <xsl:param name="coverageElement" />
        <xsl:choose>
            <xsl:when test="$coverageElement/CoverageCd = 'LIEXP' or $coverageElement/CoverageCd = 'PDEXP' or $coverageElement/CoverageCd = 'LISCH' or $coverageElement/CoverageCd = 'PDSCH'">
                <func:result select="true()" />
            </xsl:when>
            <xsl:otherwise>
                <func:result select="false()" />
            </xsl:otherwise>
        </xsl:choose>
    </func:function>

    <func:function name="ap:isOptionalCoverage">
        <xsl:param name="coverageElement" />
        <xsl:choose>
            <!--<xsl:when test="$coverageElement/CoverageCd = 'COMP'" > -->
            <xsl:when test="$coverageElement/CoverageCd='COMP' or $coverageElement/CoverageCd='PERIL'">
                <!--<xsl:when test="$coverageElement/CoverageCd = 'COMP' or $coverageElement/CoverageCd = 'PERIL' or $coverageElement/CoverageCd = 'LUSE' or $coverageElement/CoverageCd = 'BPIP' or $coverageElement/CoverageCd = 'OBEL'" > -->
                <!--<xsl:when test="$coverageElement/CoverageCd = 'COMP' or $coverageElement/CoverageCd = 'PERIL' or $coverageElement/CoverageCd = 'LUSE' or $coverageElement/CoverageCd = 'BPIP' or $coverageElement/CoverageCd = 'OBEL' or $coverageElement/CoverageCd = 'MEXCO' or $coverageElement/CoverageCd = 'LPD' or $coverageElement/CoverageCd = 'GOVT' or $coverageElement/CoverageCd = 'POLUT' or $coverageElement/CoverageCd = 'INLW' or $coverageElement/CoverageCd = 'FELIA'" > -->
                <func:result select="false()" />
            </xsl:when>
            <xsl:otherwise>
                <func:result select="true()" />
            </xsl:otherwise>
        </xsl:choose>
    </func:function>


    <xsl:template name="copyOptionalCoverages">
        <xsl:param name="rateStateElement" />
        <xsl:for-each select="$rateStateElement/CommlCoverage">
            <xsl:if test="ap:isOptionalCoverage(current())">
                <xsl:apply-templates select="." />
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="copyPremiumModificationCoverages">
        <xsl:param name="rateStateElement" />
        <xsl:for-each select="$rateStateElement/CommlCoverage">
            <xsl:if test="ap:isPremiumModificationCoverage(current())">
                <xsl:apply-templates select="." />
            </xsl:if>
        </xsl:for-each>
    </xsl:template>


    <xsl:template match="//CommlAutoLineBusiness/CommlRateState">
        <xsl:for-each select=".">
            <xsl:variable name="hasOptionalCoverages" select="ap:hasOptionalCoverages(current())" />
            <xsl:variable name="hasPremiumModificationCoverages" select="ap:hasPremiumModificationCoverages(current())" />
            <CommlRateState>
            	<xsl:apply-templates select="@id" />
                <xsl:apply-templates select="NAICCd" />
                <xsl:apply-templates select="StateProvCd" />
                <xsl:apply-templates select="QuestionAnswer" />
                <xsl:apply-templates select="CommlVeh" />
                <xsl:apply-templates select="WorkCompInd" />
                 <xsl:if test="$hasOptionalCoverages">
                 <CommlAutoOptionalCoverages>
                        <xsl:attribute name="id">
                            <xsl:value-of select="uuid:randomUUID()" />
                        </xsl:attribute>                        
                        <xsl:apply-templates select="CommlAutoHiredInfo" />
                        <xsl:apply-templates select="CommlAutoNonOwnedInfo" />
                        <xsl:apply-templates select="CommlAutoDriveOtherCarInfo" />
                        <xsl:call-template name="copyOptionalCoverages">
                            <xsl:with-param name="rateStateElement" select="." />
                        </xsl:call-template>
                 </CommlAutoOptionalCoverages>
                </xsl:if> 
                <xsl:if test="$hasPremiumModificationCoverages">
                    <CommlAutoPremiumModification>
                        <xsl:attribute name="id">
                            <xsl:value-of select="uuid:randomUUID()" />
                        </xsl:attribute> 
                        <xsl:call-template name="copyPremiumModificationCoverages">
                            <xsl:with-param name="rateStateElement" select="." />
                        </xsl:call-template>
                    </CommlAutoPremiumModification>
                </xsl:if>
            </CommlRateState>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
