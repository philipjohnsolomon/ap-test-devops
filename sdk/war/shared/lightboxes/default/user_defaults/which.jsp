<!-- Modal -->
<div class="modal fade" id="lb_which_default" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h2 class="modal-title" id="myModalLabel"><%=defaultsrb.getString("header.Which.FieldForWhichDefaultValuesCanBeSet")%></h2>
      </div>
      
      <div class="modal-body">
		<table class="table table-striped">
			<thead>
				<tr>
					<th><%=defaultsrb.getString("header.Which.Page")%></th>
					<th><%=defaultsrb.getString("header.Which.Field")%></th>
				</tr>
			</thead>
			<tbody>
				<%
				for (int ix = 0; ix < pages.length; ix++) {
					Page thisPage = pages[ix];
					List fields = thisPage.getFields();
					Iterator it = fields.iterator();
					
					while ( it.hasNext() ){
						BaseElement field = (BaseElement) it.next();
						CorrectionElement[] correctionElements = field.getCorrectionElements();
						for (int ij= 0; ij < correctionElements.length; ij++) {
							String correctionType = correctionElements[ij].getType();
							String correctionSource = correctionElements[ij].getSource();
							if (correctionType.equals(CorrectionElement.USE_SUBSTITUTE) && "prototype".equals(correctionSource) &&!"hidden".equalsIgnoreCase(field.getType())) {
								%>
								<tr>
									<td><%=JSPHelper.prepareForHTML(thisPage.getTitle())%></td>
									<td><%=JSPHelper.prepareForHTML(field.getLabel())%></td>
								</tr>
								<%
							}
						}
					}
				}
				%>
			</tbody>
		</table>
      </div>
      
    </div>
  </div>
</div>