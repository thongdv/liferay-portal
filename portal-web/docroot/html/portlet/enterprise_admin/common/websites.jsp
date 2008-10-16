<%
/**
 * Copyright (c) 2000-2008 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ include file="/html/portlet/enterprise_admin/init.jsp" %>

<%
List<Website> websites = (List<Website>)request.getAttribute("common.websites");

if (websites.isEmpty()) {
	websites = new ArrayList<Website>();

	websites.add(new WebsiteImpl());
}

String className = (String)request.getAttribute("common.className");
%>

<h3><liferay-ui:message key="websites" /></h3>

<fieldset class="block-labels">

	<%
	String fieldParam = null;

	for (int i = 0; i < websites.size(); i++){
		Website website = websites.get(i);
	%>

		<div class="lfr-form-row">
			<div class="row-fields">

				<%
				fieldParam = "websiteId" + i;
				%>

				<input id="<portlet:namespace /><%= fieldParam %>" name="<portlet:namespace /><%= fieldParam %>" type="hidden" value="" />

				<%
				fieldParam = "websiteUrl" + i;
				%>

				<div class="ctrl-holder">
					<label for="<portlet:namespace /><%= fieldParam %>"><liferay-ui:message key="url" /></label>

					<liferay-ui:input-field model="<%= Website.class %>" bean="<%= website %>" field="url" fieldParam="<%= fieldParam %>" />
				</div>

				<%
				fieldParam = "websiteTypeId" + i;
				%>

				<div class="ctrl-holder">
					<label for="<portlet:namespace /><%= fieldParam %>"><liferay-ui:message key="type" /></label>

					<select id="<portlet:namespace /><%= fieldParam %>" name="<portlet:namespace /><%= fieldParam %>">

						<%
						List<ListType> websiteTypes = ListTypeServiceUtil.getListTypes(className + ListTypeImpl.WEBSITE);

						for (ListType suffix : websiteTypes) {
						%>

							<option <%= (suffix.getListTypeId() == website.getTypeId()) ? "selected" : "" %> value="<%= suffix.getListTypeId() %>"><liferay-ui:message key="<%= suffix.getName() %>" /></option>

						<%
						}
						%>

					</select>
				</div>

				<%
				fieldParam = "websitePrimary" + i;
				%>

				<div class="ctrl-holder primary-ctrl">
					<label class="inline-label" for="<portlet:namespace /><%= fieldParam %>">
						<liferay-ui:message key="primary" />

						<input id="<portlet:namespace /><%= fieldParam %>" name="<portlet:namespace />primary" type="radio" value="1" />
					</label>
				</div>
			</div>
		</div>

	<%
	}
	%>

</fieldset>

<script type="text/javascript">
	jQuery(
		function () {
			new Liferay.autoFields(
				{
					container: '#websites > fieldset',
					baseRows: '.lfr-form-row',
					fieldIndexes: '<portlet:namespace />websiteIndexes'
				}
			);
		}
	);
</script>