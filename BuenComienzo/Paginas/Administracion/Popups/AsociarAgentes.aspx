<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AsociarAgentes.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Popups.AsociarAgentes" %>

<form id="frmAsociarAgentes">
    <div class="row">
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Agentes</label>
                </div>
                <div class="col-sm-10">
                    <select id="ddlAgentes" class="form-control select2" data-validation="required" multiple="multiple"></select>
                </div>
            </div>
        </div>
    </div>
</form>
