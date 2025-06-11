<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AsociarSedes.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Popups.AsociarSedes" %>

<form id="frmAsociarSedes">
    <div class="row">
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Sedes</label>
                </div>
                <div class="col-sm-10">
                    <select id="ddlSedes" class="form-control select2" data-validation="required" multiple="multiple"></select>
                </div>
            </div>
        </div>
    </div>
</form>
