<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NuevoReporte.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Popups.NuevoReporte" %>

<form id="frmNuevoReporte">
    <div class="row">
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Nombre</label>
                </div>
                <div class="col-sm-8">
                    <input type="text" id="txtNombre" runat="server" class="form-control" data-validation="required" maxlength="150" vacio="n">
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Descripción</label>
                </div>
                <div class="col-sm-10">
                    <textarea type="text" rows="3" runat="server" id="txtDescripcion" data-validation="required" class="form-control" maxlength="1000" style="resize: none" vacio="n"></textarea>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Query</label>
                </div>
                <div class="col-sm-10 group">
                    <textarea type="text" rows="15" runat="server" id="txtQuery" data-validation="required" class="form-control"  style="resize: none" vacio="n" query="s"></textarea>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="form-group" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-6" style="padding: 0px 0px 0px 0px;">
                    <div class="col-sm-4">
                        <label class="control-label">Tipo de campo</label>
                    </div>
                    <div class="col-sm-8">
                        <select id="ddlCampo" class="form-control" runat="server"></select>
                    </div>
                    <div class="col-sm-4">
                        <label class="control-label">Nombre del Campo</label>
                    </div>
                    <div class="col-sm-8">
                        <input type="text" id="txtNombreCampo" runat="server" class="form-control" maxlength="50">
                    </div>
                    <div class="col-sm-12">
                        <div class="col-sm-4" style="padding: 4px 4px 4px 4px;">
                        </div>
                        <div class="col-sm-8" style="padding: 4px 4px 4px 4px;">&nbsp;
                            <button type="button" id="btnAdicionar" class="btn btn-BCA2 btn-label-left">
                                <span><i class="fa fa-file-o"></i></span>Adicionar
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6" style="padding: 0px 0px 0px 0px;">
                    <div class="col-sm-12">
                        <select id="ddlCampos"  class="form-control" runat="server" size="5"></select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="form-group" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-6" style="padding: 0px 0px 0px 0px;">
                </div>
                <div class="col-sm-6" style="padding: 4px 4px 4px 4px; text-align: right">
                    <button type="button" id="btnEliminar" class="btn btn-BCA2 btn-label-left">
                        <span><i class="fa fa-file-o"></i></span>Eliminar
                    </button>&nbsp;&nbsp;
                </div>
            </div>
        </div>
    </div>
        
        <input type="hidden" runat="server" id="idReporte" />
</form>