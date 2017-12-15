<div class="cover_text ${resourceType}_intro">
	<h3>${artifactTitle}</h3>
	<ul>
		<li>
			<h4>Behaviors: Where The Magic Happens</h4>
			<p>Behaviors bring the framework to life by creating a dynamic experience based on <span class="keyword">pre-conditions</span>. <span class="keyword">Pre-conditions</span> are variables against which decisions can be made about the conditional display of <span class="keyword">Pages</span>, <span class="keyword">Sections</span>, <span class="keyword">Fields</span>, <span class="keyword">Connectors</span>, or <span class="keyword">Instructions</span>. Behaviors use these variables to shape your <span class="keyword">pages/sections/fields/connectors/instructions</span> so that they're perfect for the case at hand. 
			<p class="hint"><span class="hint">Terminology Tip:</span> throughout the toolkit, you may see <span class="keyword">page entities</span> referred to. <span class="keyword">Page entities</span> are the objects that constitute the transaction. This broad term encompasses actual <span class="keyword">pages</span> in a <span class="keyword">transaction</span> or <span class="keyword">page library</span> but also includes the components within including <span class="keyword">page elements</span> <span class="example">(sections)</span>,  <span class="keyword">fields</span>, <span class="keyword">connectors</span>, and <span class="keyword">instructions</span>.</p>
		</li>
		<li>
			<h4>Include, Exclude, Alter</h4>
			<p>An individual <span class="keyword">behavior</span> does one of three things - It either <span class="bold">includes</span>, <span class="bold">excludes</span>, or <span class="bold">alters</span> one or more <span class="keyword">page entities</span> when it fires. For example, for a particular type of user, you may choose to exclude a particular set of <span class="keyword">fields</span>. A behavior makes this happen by modifying, at runtime, the superset of fields prescribed in the base <span class="keyword">transaction</span> definition. Common cases of variability supported by behaviors are variation by U.S. State, User Type, or Effective Date.</p>
		</li>
		<li>
			<h4>Piping Hot Fields</h4>
			<p>It's possible to implement behaviors to support "if this, show that" type behavior on an intra-page basis (that is to say, real-time). This is done using <span class="keyword">hot fields</span>. Fields marked as <span class="keyword">hot fields</span> 'call home' when their values change, the impact is assessed, and on the fly, behaviors act accordingly to alter other page entities based on the results. A behavior coupled with a hot field makes it possible to support a requirement like <span class="example">"show the prior address section if the years at current address is less than 3"</span>. In this case, an inclusion <span class="keyword">behavior</span> targeted at the years at current address <span class="keyword">page entity</span> coupled with a years at current address field marked as <span class="keyword">hot</span> makes this happen.</p>
		</li>		
	</ul>
</div>