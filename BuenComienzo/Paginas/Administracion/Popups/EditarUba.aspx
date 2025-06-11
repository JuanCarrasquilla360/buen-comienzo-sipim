<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarUba.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Popups.EditarUba" %>

<form id="frmEditarUba">
    <div class="row">
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Id Uba</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtIdUba" class="form-control" disabled="disabled" >
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Nombre uba</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtUba" class="form-control" disabled="disabled" >
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Tipo de uba</label>
                </div>
                <div class="col-sm-4">
                    <select id="ddlTipoUba" class="form-control ddlTipoUba" data-validation="required"></select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Uba sistema SIBC</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtUbaSistema" style="text-transform: uppercase;" class="form-control" maxlength="7">
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Activo</label>
                </div>
                <div class="col-sm-4">
                    <label><input type='checkbox' id="chkActivo" class='flat-red' style='opacity: 0;' runat="server"></label>
                </div>
            </div>
        </div>
    </div>
</form>
