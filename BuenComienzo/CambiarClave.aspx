<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CambiarClave.aspx.cs" Inherits="BuenComienzo.CambiarClave" %>

<form id="frmCambiarClave">
    <div class="row">
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-4">
                    <label class="control-label">Contraseña</label>
                </div>
                <div class="col-sm-8">
                    <input type="password" name="txtClave_confirmation" id="txtClave_confirmation" runat="server" class="form-control" data-validation="required">
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-4">
                    <label class="control-label">Confirmación de contraseña</label>
                </div>
                <div class="col-sm-8">
                    <input type="password" name="txtClave" id="txtClave" runat="server" class="form-control" data-validation="confirmation required">
                </div>
            </div>
        </div>
    </div>
</form>
