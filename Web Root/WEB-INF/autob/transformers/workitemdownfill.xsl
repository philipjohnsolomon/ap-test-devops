<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" />
    <xsl:template match="/Account">
        <CommlAutoPolicyQuoteInqRq>
            <RqUID />
            <TransactionRequestDt />
            <CurCd>
                <xsl:value-of select="CurCd"></xsl:value-of>
            </CurCd>

            <xsl:apply-templates select="MiscParty[MiscPartyInfo/MiscPartyRoleCd='NamedInsured'][1]" />
            <xsl:if test="not(MiscParty[MiscPartyInfo/MiscPartyRoleCd='NamedInsured'][1])">
                <xsl:apply-templates select="MiscParty[MiscPartyInfo/MiscPartyRoleCd='AccountHolder'][1]" />
            </xsl:if>

        </CommlAutoPolicyQuoteInqRq>
    </xsl:template>

    <xsl:template match="NameTypeCd" />

    <xsl:template match="CommunicationUseCd">
        <CommunicationUseCd>Business</CommunicationUseCd>
    </xsl:template>

    <xsl:template match="AddrTypeCd">
        <AddrTypeCd>MailingAddress</AddrTypeCd>
    </xsl:template>

    <xsl:template match="MiscParty">
        <InsuredOrPrincipal>
            <xsl:apply-templates select="ItemIdInfo" />
            <xsl:apply-templates select="GeneralPartyInfo" />
            <InsuredOrPrincipalInfo>
                <InsuredOrPrincipalRoleCd>Insured</InsuredOrPrincipalRoleCd>
                <xsl:apply-templates select="../BusinessInfo" />
            </InsuredOrPrincipalInfo>
        </InsuredOrPrincipal>
    </xsl:template>

    <xsl:template match="NameInfo">
        <NameInfo>
            <xsl:apply-templates select="CommlName" />
            <xsl:apply-templates select="PersonName" />
            <LegalEntityCd>
                <xsl:value-of select="/Account/MiscParty[MiscPartyInfo/MiscPartyRoleCd='AccountHolder'][1]/GeneralPartyInfo/NameInfo/LegalEntityCd" />
            </LegalEntityCd>
            <xsl:apply-templates select="TaxIdentity" />
            <xsl:apply-templates select="NameTypeCd" />
        </NameInfo>
    </xsl:template>

    <xsl:template match="TaxId">
        <TaxId>
            <xsl:if test="@encrypt">
                <xsl:attribute name="encrypt">
    				<xsl:value-of select="@encrypt" />
 			 	</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="." />
        </TaxId>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="node()" />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
