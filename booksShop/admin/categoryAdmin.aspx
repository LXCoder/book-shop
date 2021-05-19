<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="categoryAdmin.aspx.cs" Inherits="booksShop.admin.categoryAdmin" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../assets/css/admin/category.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <!--=============================================
	=            �������         =
	=============================================-->

    <div class="shop-page-content mb-50">
        <div class="container">
            <div class="row">

                <div class="col-lg-12">
                    <div class="panel-group" id="accordion">

                        <%
                            for (int i = 0; i < categoryList.Count; i++)
                            {
                                 
                        %>
                        <div class="panel panel-default" id="Unit<%=categoryList[i].cid.Trim() %>">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-8">
                                        <h4 class="panel-title">
                                            <a  id="Cname<%=categoryList[i].cid.Trim() %>" 
                                                data-toggle="collapse" data-parent="#accordion" 
                                                href="#collapse<%=categoryList[i].cid.Trim() %>"
                                                title="<%=categoryList[i].desc %>">
                                                <%=categoryList[i].cname %>
                                            </a>
                                        </h4>
                                    </div>
                                    <div class="col-4">
                                        <a data-toggle="modal" data-target="#addModal2" onclick="category_passVal(0,0,3)"><i class="fa fa-plus fa-2x" title="��Ӷ�������"></i></a>
									    <a data-toggle="modal" data-target="#addModal1" onclick="category_passVal('<%=categoryList[i].cid.Trim() %>',0,2)">
										    <i class="fa fa-edit fa-2x" title="�޸�"></i>
									    </a>
									    <a onclick="category_delete('<%=categoryList[i].cid.Trim() %>',1)"><i class="fa fa-trash fa-2x" title="ɾ��"></i></a>

                                    </div>
                                </div>
                            </div>
                            <div id="collapse<%=categoryList[i].cid.Trim() %>" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <table id="Table<%=categoryList[i].cid.Trim() %>" class="table table-condensed mytable">
                                        <tbody>
                                    <%
                                 for (int j = 0; j < categoryList[i].childrens.Count; j++)
                                 { 
                                    %>
                                            <tr id="Unit<%=categoryList[i].childrens[j].cid.Trim() %>" >
								                <td id="Cname<%=categoryList[i].childrens[j].cid.Trim() %>"><%=categoryList[i].childrens[j].cname.Trim() %></td>
								                <td id="Desc<%=categoryList[i].childrens[j].cid.Trim() %>"><%=categoryList[i].childrens[j].desc.Trim() %></td>
								                <td>
									                <a data-toggle="modal" data-target="#addModal2" onclick="category_passVal('<%=categoryList[i].childrens[j].cid.Trim() %>','<%=categoryList[i].childrens[j].pid.Trim() %>',4)">
										                <i class="fa fa-edit fa-2x" title="�޸�"></i>
									                </a>
									                <a onclick="category_delete('<%=categoryList[i].childrens[j].cid.Trim() %>',2)"><i class="fa fa-trash fa-2x" title="ɾ��"></i></a>
								                </td>
							                </tr>
                                    <%
                                 }
                                    %>
                                           </tbody> 
                                    </table>
                                </div>
                            </div>
                        </div>
                        <%
                                  
                             }
                        %>
                    </div>




                </div>
            </div>
        </div>
    </div>

    <!--=====  End of �������  ======-->


    <div class="hover-icons">
        <ul>
            <li><a data-toggle="modal" data-target="#addModal1" title="���һ������ " class="functionicon icon-add icon-position-add" onclick="category_passVal(0,0,1)"></a></li>
        </ul>
    </div>

    <!--=============================================
	=            ���һ������ģ̬��         =
	=============================================-->

    <div class="modal fade" id="addModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="model_title1">���һ������</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>

                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label for="category_cname1">��������</label>
                        <input type="text" class="form-control" id="category_cname1" placeholder="�������������" />
                    </div>
                    <div class="form-group">
                        <label for="category_desc1">��������</label>
                        <textarea class="form-control" id="category_desc1" rows="3" placeholder="�������������"></textarea>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
                    <button type="button" id="add_category1" class="btn btn-primary">���һ������</button>
                    <button type="button" id="edit_category1" class="btn btn-primary hidden">�ύ�޸�</button>

                </div>
            </div>
        </div>
    </div>

    <!--=====  End of ���һ������ģ̬��  ======-->

    <!--=============================================
	=            ��Ӷ�������ģ̬��         =
	=============================================-->

    <div class="modal fade" id="addModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="model_title2">��Ӷ�������</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>

                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label for="category_cname2">��������</label>
                        <input type="text" class="form-control" id="category_cname2" placeholder="�������������" />
                    </div>
                    <div class="form-group">
                        <label for="cname1">һ������</label>
                        <select name="pid" id="pid">
                            <option value="0">===ѡ��1������===</option>
                            <%
                                for (int i = 0; i < categoryList.Count; i++)
                                {
                            %>
                            <option value="<%=categoryList[i].cid.Trim()%>">
                                <%=categoryList[i].cname.Trim()%>
                            </option>
                            <% 
                                 }    
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="category_desc2">��������</label>
                        <textarea class="form-control" id="category_desc2" rows="3" placeholder="�������������"></textarea>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
                    <button type="button" id="add_category2" class="btn btn-primary">��Ӷ�������</button>
                    <button type="button" id="edit_category2" class="btn btn-primary hidden">�ύ�޸�</button>

                </div>
            </div>
        </div>
    </div>

    <!--=====  End of ���һ������ģ̬��  ======-->


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script src="../assets/js/admin/category.js"></script>

</asp:Content>
