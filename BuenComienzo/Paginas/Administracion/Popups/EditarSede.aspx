<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarSede.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Popups.EditarSede" %>

<form id="frmEditarSede">
    <div class="row">
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Id Sede</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtIdSede" class="form-control" disabled="disabled">
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Nombre sede</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtNombreSede" class="form-control" style="text-transform: uppercase;" maxlength="100" data-validation="required">
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Codigo sede SIBC</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtCodigoSedeSIBC" class="form-control" maxlength="10" data-validation="required">
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Dirección</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtDireccion" class="form-control" style="text-transform: uppercase;" maxlength="50" data-validation="required">
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Teléfono</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtTelefono" class="form-control" maxlength="10">
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Celular</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtCelular" class="form-control" maxlength="10" data-validation="required">
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Comuna</label>
                </div>
                <div class="col-sm-4">
                    <select id="ddlComuna" class="form-control" data-validation="required"></select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Barrio</label>
                </div>
                <div class="col-sm-4">
                    <select id="ddlBarrio" class="form-control" data-validation="required">
                        <option value="">Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Correo</label>
                </div>
                <div class="col-sm-4">
                    <input type="email" id="txtCorreo" class="form-control" maxlength="100">
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Tenencia Inmueble</label>
                </div>
                <div class="col-sm-4">
                    <select id="ddlTeneciaInmueble" class="form-control" data-validation="required"></select>
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
