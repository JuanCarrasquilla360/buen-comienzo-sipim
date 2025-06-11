<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RenovarSession.aspx.cs" Inherits="BuenComienzo.RenovarSession" %>

<form id="frmRenovarSession" runat="server">
    <div class="row" style="padding: 4px 4px 4px 4px;">
        <div class="col-sm-12">
            <h5>Su sessión ha caducado, ingrese sus credenciales para renovarla y conservar la información actual.</h5>
        </div>
    </div>
    <div class="row" style="padding: 4px 4px 4px 4px;">
        <div class="col-sm-12">
            <div class="col-sm-4">
                <label class="control-label">Usuario</label>
            </div>
            <div class="col-sm-8">
                <input type="text" name="txtUsuario" id="txtUsuario" runat="server" class="form-control" data-validation="required">
            </div>
        </div>
    </div>
    <div class="row" style="padding: 4px 4px 4px 4px;">
        <div class="col-sm-12">
            <div class="col-sm-4">
                <label class="control-label">Contraseña</label>
            </div>
            <div class="col-sm-8">
                <input type="password" name="txtPassword" id="txtPassword" runat="server" class="form-control" data-validation="required">
            </div>
        </div>
    </div>
    <div class="row" style="padding: 4px 4px 4px 4px;">
        <div class="col-md-12" style="text-align: center;margin-top: 3px;">
            <input id="btnIngresar" type="button" class="btn btn-cincopasitos" value="Ingresar">
        </div>
    </div>
</form>

