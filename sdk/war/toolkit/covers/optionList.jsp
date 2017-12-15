<div class="cover_text ${resourceType}_intro">
	<h3>${artifactTitle}</h3>
	<ul>
		<li>
			<h4>Lists: The Contents for Drop-Downs</h4>
			<p>When you see a drop-down list of values on an AgencyPort page, the values in that drop down are usually coming from right here in <span class="keyword">list</span> land. Each option in a <span class="keyword">list</span> consists of two parts, a <span class="bold">display value</span> <span class="example">(eg "Chevrolet")</span> and a <span class="bold">data value</span> <span class="example">(eg "CHEV")</span>. The <span class="keyword">display value</span> should be meaningful to the casual user of the system. The <span class="keyword">data value</span> is what is actually stored away 'behind the scenes' when a user makes a selection and is often meaningful to downstream systems.</p><p>This particular tool will help you create and manage two types of <span class="keyword">lists</span>:
		</li>
		<li>
			<h4>1) Option List Collections</h4>
			<p>The most frequently used type of <span class="keyword">list</span> is an <span class="keyword">option list</span>. Think of an option list as a static set of display-value/data-value pairs. Good examples of fields where option lists are used are U.S. State, or Occupation Type. A whole bunch of these individual <span class="keyword">option lists</span> can exist in a <span class="keyword">collection</span>. A <span class="keyword">collection</span> in fact, is just an arbitrary grouping of option lists.
		</li>
		<li>
			<h4>2) Dynamic List Collections</h4>
			<p><span class="keyword">Dynamic lists</span> on the other hand are used in cases where the values that go in a list are populated from values previously entered by the user. For example, if prompting someone to assign a piece of property to a particular location, the list of locations will in all likelihood be dynamically generated based on values entered in a prior section of the application by the user. Dynamic lists are used in this case to build the locations drop-drown.</p>
		</li>		
	</ul>
</div>