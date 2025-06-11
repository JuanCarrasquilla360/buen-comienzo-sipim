<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarUsuarios.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Popups.EditarUsuarios" %>

<form id="frmEditarUsuario">
    <div class="row">
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Tipo de documento</label>
                </div>
                <div class="col-sm-4">
                    <select id="ddlTipoDocumento" runat="server" class="form-control" data-validation="required">
                        <option value="">--Seleccione--</option>
                        <option value="CC">Cédula de ciudadanía</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Nro. de documento</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtNumeroDocumento" runat="server" class="form-control" data-validation="required" maxlength="12" >
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Perfil</label>
                </div>
                <div class="col-sm-4">
                    <select id="ddlPerfil" class="form-control" runat="server" data-validation="required"></select>
                </div>

            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Primer nombre</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtPrimerNombre" runat="server" class="form-control" data-validation="required" >
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Segundo nombre</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtSegundoNombre" runat="server" class="form-control" >
                </div>

            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Primer apellido</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtPrimerApellido" runat="server" class="form-control" data-validation="required">
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Segundo apellido</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtSegundoApellido" runat="server" class="form-control" >
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">teléfono</label>
                </div>
                <div class="col-sm-4">
                    <input type="tel" id="txtTelefono" runat="server" class="form-control" maxlength="10" >
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Celular</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtCelular" runat="server" class="form-control" data-validation="number required" maxlength="10" >
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Fecha de nacimiento</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtFechaNacimiento" runat="server" data-validation="required" class="form-control"  data-mask>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Correo electrónico</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtCorreoElectronico" runat="server" class="form-control" data-validation="email" >
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Correo electrónico laboral</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" id="txtCorreoElectronicoLaboral" runat="server" class="form-control"  >
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Coordinador asignado</label>
                </div>
                <div class="col-sm-4">
                    <select id="ddlCoordinador" class="form-control" runat="server"></select>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Contraseña</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" name="txtClave_confirmation" id="txtClave_confirmation" runat="server" class="form-control" data-validation="required">
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Confirmación de contraseña</label>
                </div>
                <div class="col-sm-4">
                    <input type="text" name="txtClave" id="txtClave" runat="server" class="form-control" data-validation="confirmation required">
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-12">
                    <label class="control-label">Activo</label>&nbsp;&nbsp;<label><input type='checkbox' id="chkActivo" class='flat-red' style='opacity: 0;' runat="server"></label>&nbsp;&nbsp;
                        <label class="control-label">Cambio Contraseña</label>&nbsp;&nbsp;<label><input type='checkbox' id="chkCambioClave" class='flat-red' style='opacity: 0;' runat="server"></label>
                </div>
            </div>
        </div>
    </div>
</form>
