<%@page import="com.agencyport.locale.IResourceBundle"%>
<%@page import="com.agencyport.locale.ResourceBundleManager"%>
<%@page import="com.agencyport.locale.ILocaleConstants"%>
<%@page import="com.agencyport.locale.ResourceBundleStringUtils"%>
<%@page import="com.agencyport.account.AccountDetails" %>

<%
	IResourceBundle coreRB = ResourceBundleManager.get().getHTMLEncodedResourceBundle(ILocaleConstants.CORE_PROMPTS_BUNDLE);
%>

<footer>
	<div class="container">	
		<div class="footer-main row">
			<div class="col-xs-6 col-sm-3 col-md-3 ap-about">
				<h3><%= coreRB.getString("header.Footer.AboutUs") %></h3>
				<ul class="link-list">
					<li><a href="#"><%= coreRB.getString("label.Footer.AboutOurCompany") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.OurServices") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.MeetOurTeam") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.ExploreOurPortfolio") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.GetInTouch") %></a></li>
				</ul>
			</div>
			<div class="col-xs-6 col-sm-3 col-md-3 ap-important">
				<h3><%= coreRB.getString("header.Footer.Important") %></h3>
				<ul class="link-list">
					<li><a href="#"><%= coreRB.getString("label.Footer.PressRelease") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.TermsAndConditions") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.PrivacyPolicy") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.CareerCenter") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.SubmitAClaim") %></a></li>
				</ul>
			</div>
			<div class="col-xs-6 col-sm-3 col-md-3 ap-service">
				<h3><%= coreRB.getString("header.Footer.Service") %></h3>
				<ul class="link-list">
					<li><a href="#"><%= coreRB.getString("label.Footer.AgencyAppointments") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.UnderwritingGuidelines") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.DocumentLibrary") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.AgencyAgreements") %></a></li>
					<li><a href="#"><%= coreRB.getString("label.Footer.ContactUnderwriter") %></a></li>
				</ul>
			</div>
			<div class="col-xs-6 col-sm-3 col-md-3 ap-contact">
				<h3><%= coreRB.getString("header.Footer.Contact") %></h3>
				<ul class="postal">
					<li><%= coreRB.getString("label.Footer.Agencyport") %></li>
					<li><%= coreRB.getString("label.Footer.SleeperStreet") %></li>
					<li><%= coreRB.getString("label.Footer.Boston") %></li>
				</ul>
				<ul class="remote">
					<li class="telephone"><i class="fa"></i><%= coreRB.getString("label.Footer.Telephone") %></li>
					<li class="email"><i class="fa"></i><%= coreRB.getString("label.Footer.Email") %></li>
				</ul>
			</div>
		</div> <!-- /footer-main row -->
		
		<div class="footer-credit">
			<p>
				&copy;<script type="text/javascript">document.write((new Date()).getFullYear());</script> <%= coreRB.getString("label.Footer.RightsReserved") %>
			</p>
		</div> <!-- /footer-credit -->	

	</div> <!-- /footer container -->
</footer>