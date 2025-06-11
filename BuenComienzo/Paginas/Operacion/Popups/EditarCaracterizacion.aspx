<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarCaracterizacion.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.EditarCaracterizacion" %>

<form id="EditarCaracterizacion">
    <div class="row">
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Número identificación*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtNumeroIdentificacion" maxlength="15" data-validation="required"/>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Tipo de identificación*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlTipoIdentificacion" data-validation="required">
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Fecha de caracterización*</label>
                </div>
                <div class="col-sm-4">
                    <div class='input-group' id='fechaCaracterizacion'>
                        <input type='text' class="form-control" id="txtfechaCaracterizacion" readonly="readonly" style="background-color: white" />
                        <div class="input-group-addon">
                            <div class="input-group-text" style="cursor: pointer">
                                <span class="far fa-calendar-alt fa-lg"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Cuéntame*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control select" aria-label="Default select" id="ddlCuentame" data-validation="required">
                    </select>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Nombre de la FAMI Responsable</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtNombreFamiResponsable" data-validation="required" maxlength="50" style="text-transform: uppercase" disabled="disabled"/>
                </div>                
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Primer nombre*</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtPrimerNombre" data-validation="required" maxlength="50" style="text-transform: uppercase"/>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Segundo nombre</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtSegundoNombre" maxlength="50" style="text-transform: uppercase"/>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Primer apellido*</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtPrimerApellido" data-validation="required" maxlength="50" style="text-transform: uppercase"/>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Segundo apellido</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtSegundoApellido" maxlength="50" style="text-transform: uppercase"/>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Fecha de nacimiento*</label>
                </div>
                <div class="col-sm-4">
                    <div class='input-group' id='fechaNacimiento'>
                        <input type='text' class="form-control" id="txtFechaNacimiento" style="background-color: white" />
                        <div class="input-group-addon">
                            <div class="input-group-text" style="cursor: pointer">
                                <span class="far fa-calendar-alt fa-lg"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Sexo*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlSexo" data-validation="required">
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Nacionalidad*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlNacionalidad" data-validation="required">
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Teléfono</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtTelefono" maxlength="10"/>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Celular*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtCelular" data-validation="required" maxlength="10"/>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Dirección*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtDireccion" maxlength="50" data-validation="required" style="text-transform: uppercase"/>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Comuna*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlComuna" data-validation="required">
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Barrio*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlBarrio" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Observaciones dirección</label>
                </div>
                <div class="col-sm-4">
                    <textarea id="txtObservacionesDireccion" cols="40" rows="2" class="form-control" style="resize: none; text-transform: uppercase" maxlength="100"></textarea>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Ciclo Vital*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlCicloVital" data-validation="required">
                    </select>
                </div>
            </div>
        </div>       

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Semanas de gestación*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtSemanasGestacion" data-validation="required" maxlength="2" disabled="disabled"/>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Asiste CPN o CXN o VI</label>
                </div>
                <div class="col-sm-4">
                    <input type='checkbox' id="chkAsisteCPNoCXNoVI" class='flat-red' style='opacity: 0;' runat="server" />
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Esquema de vacunación*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlEsquemaVacunacion" data-validation="required">
                    </select>
                </div>

                <div class="col-sm-2">
                    <label class="control-label">Es madre adolescente?</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlMadreAdolescente" data-validation="required" disabled="disabled">
                    </select>
                </div>

                <%--<div class="col-sm-2">
                    <label class="control-label">Número de vacunas*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtNumeroVacunas" data-validation="required" maxlength="2" disabled="disabled"/>
                </div>--%>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Tipo de afiliación*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlTipoAfiliacion" data-validation="required">
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">EAPB*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlEAPB" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Parentesco red de apoyo*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlParentescoRedApoyo" data-validation="required">
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Nombre completo red de apoyo*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtNombreCompletoRedApoyo" data-validation="required" maxlength="100" style="text-transform: uppercase" />
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Celular red de apoyo*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtCelularRedApoyo" data-validation="required" maxlength="10"/>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Matrícula</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtMatricula" disabled="disabled"/>
                </div>
            </div>
        </div>
    </div>
</form>
