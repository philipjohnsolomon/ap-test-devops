<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
							xmlns:java="http://xml.apache.org/xslt/java"
							exclude-result-prefixes="java">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="*[contains(local-name(),'PolicyQuoteInqRq')]">
		<Account>
			<CurCd>USD</CurCd>
			<TransactionRequestDt>
				<xsl:value-of select="java:format(java:java.text.SimpleDateFormat.new('yyyy-MM-dd'), java:java.util.Date.new())" />
			</TransactionRequestDt>
			<xsl:choose>
				<xsl:when test="InsuredOrPrincipal[InsuredOrPrincipalInfo/InsuredOrPrincipalRoleCd='Insured']/GeneralPartyInfo/NameInfo/TaxIdentity[TaxIdTypeCd='FEIN']/TaxIdTypeCd='FEIN'">
					<BroadLOBCd>C</BroadLOBCd>
				</xsl:when>
				<xsl:when test="InsuredOrPrincipal[InsuredOrPrincipalInfo/InsuredOrPrincipalRoleCd='Insured']/GeneralPartyInfo/NameInfo/TaxIdentity[TaxIdTypeCd='SSN']/TaxIdTypeCd='SSN'">
					<BroadLOBCd>P</BroadLOBCd>
				</xsl:when>
				<xsl:otherwise>
					<BroadLOBCd>U</BroadLOBCd>
				</xsl:otherwise>
			</xsl:choose>
			<MiscParty>
				<GeneralPartyInfo>
					<xsl:apply-templates select="InsuredOrPrincipal[InsuredOrPrincipalInfo/InsuredOrPrincipalRoleCd='Insured']/GeneralPartyInfo/NameInfo"/>
					<xsl:apply-templates select="InsuredOrPrincipal[InsuredOrPrincipalInfo/InsuredOrPrincipalRoleCd='Insured']/GeneralPartyInfo/Communications"/>
					
					<xsl:choose>
						<xsl:when test="InsuredOrPrincipal[InsuredOrPrincipalInfo/InsuredOrPrincipalRoleCd='Insured']/GeneralPartyInfo/Addr[AddrTypeCd='MailingAddress']">
							<xsl:apply-templates select="InsuredOrPrincipal[InsuredOrPrincipalInfo/InsuredOrPrincipalRoleCd='Insured']/GeneralPartyInfo/Addr[AddrTypeCd='MailingAddress']"/>
						</xsl:when>
						<xsl:when test="InsuredOrPrincipal[InsuredOrPrincipalInfo/InsuredOrPrincipalRoleCd='Insured']/GeneralPartyInfo/Addr[AddrTypeCd='StreetAddress']">
							<xsl:apply-templates select="InsuredOrPrincipal[InsuredOrPrincipalInfo/InsuredOrPrincipalRoleCd='Insured']/GeneralPartyInfo/Addr[AddrTypeCd='StreetAddress']"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="HomeLineBusiness/Dwell[PrincipalUnitAtRiskInd='1']/Location/Addr"/>
						</xsl:otherwise>
					</xsl:choose>
				</GeneralPartyInfo>
				<MiscPartyInfo>
					<MiscPartyRoleCd>AccountHolder</MiscPartyRoleCd>
				</MiscPartyInfo>
			</MiscParty>
			<xsl:apply-templates select="InsuredOrPrincipal[InsuredOrPrincipalInfo/InsuredOrPrincipalRoleCd='Insured']/InsuredOrPrincipalInfo/BusinessInfo"/>
		</Account>
	</xsl:template>
	<xsl:template match="CommunicationUseCd">
		<xsl:choose>
			<xsl:when test="text()='Home'">
				<CommunicationUseCd>Home</CommunicationUseCd>
			</xsl:when>
			<xsl:otherwise>
				<CommunicationUseCd>Business</CommunicationUseCd>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="Addr">
		<Addr>
			<AddrTypeCd>MailingAddress</AddrTypeCd>
			<xsl:apply-templates select="Addr1" />
			<xsl:apply-templates select="Addr2" />
			<xsl:apply-templates select="City" />
			<xsl:apply-templates select="StateProvCd" />
			<xsl:apply-templates select="PostalCode" />
		</Addr>
	</xsl:template>
	<xsl:template match="PhoneInfo">
		<PhoneInfo>
			<xsl:choose>
				<xsl:when test="PhoneTypeCd">
					<xsl:apply-templates select="PhoneTypeCd" />
				</xsl:when>
				<xsl:otherwise>
					<PhoneTypeCd>Phone</PhoneTypeCd>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="CommunicationUseCd">
					<xsl:apply-templates select="CommunicationUseCd" />
				</xsl:when>
				<xsl:otherwise>
					<CommunicationUseCd>Business</CommunicationUseCd>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="PhoneNumber" />
		</PhoneInfo>
	</xsl:template>
	<xsl:template match="NameInfo">
		<NameInfo>
			<xsl:if test="CommlName">
				<xsl:apply-templates select="CommlName"/>
				<NameTypeCd>C</NameTypeCd>
			</xsl:if>
			<xsl:if test="PersonName">
				<xsl:apply-templates select="PersonName"/>
				<NameTypeCd>P</NameTypeCd>
			</xsl:if>
			<xsl:apply-templates select="LegalEntityCd"/>
			<xsl:apply-templates select="TaxIdentity"/>
		</NameInfo>
	</xsl:template>
	
	<xsl:template match="TaxId">
		<TaxId>
			<xsl:if test="@encrypt">
				<xsl:attribute name="encrypt">
    				<xsl:value-of select="@encrypt" />
 			 	</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="."  />
		</TaxId>
	</xsl:template>
	
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
