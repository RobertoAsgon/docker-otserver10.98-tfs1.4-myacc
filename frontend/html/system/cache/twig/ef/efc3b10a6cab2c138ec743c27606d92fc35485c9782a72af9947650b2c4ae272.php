<?php

use Twig\Environment;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Markup;
use Twig\Sandbox\SecurityError;
use Twig\Sandbox\SecurityNotAllowedTagError;
use Twig\Sandbox\SecurityNotAllowedFilterError;
use Twig\Sandbox\SecurityNotAllowedFunctionError;
use Twig\Source;
use Twig\Template;

/* account.change_password.html.twig */
class __TwigTemplate_f46f9ea9e560c9f5d08567f51a636d4ac0c4b612f9b4b5ca51d582afb258a6bb extends \Twig\Template
{
    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = [
        ];
    }

    protected function doDisplay(array $context, array $blocks = [])
    {
        // line 1
        echo "Please enter your current password and a new password. For your security, please enter the new password twice.<br/>
<br/>
<form action=\"";
        // line 3
        echo twig_escape_filter($this->env, call_user_func_array($this->env->getFunction('getLink')->getCallable(), ["account/password"]), "html", null, true);
        echo "\" method=\"post\">
\t<div class=\"TableContainer\">
\t\t<table class=\"Table1\" cellpadding=\"0\" cellspacing=\"0\">
\t\t\t<div class=\"CaptionContainer\">
\t\t\t\t<div class=\"CaptionInnerContainer\">
\t\t\t\t\t<span class=\"CaptionEdgeLeftTop\" style=\"background-image:url(";
        // line 8
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-edge.gif);\"></span>
\t\t\t\t\t<span class=\"CaptionEdgeRightTop\" style=\"background-image:url(";
        // line 9
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-edge.gif);\"></span>
\t\t\t\t\t<span class=\"CaptionBorderTop\" style=\"background-image:url(";
        // line 10
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/table-headline-border.gif);\"></span>
\t\t\t\t\t<span class=\"CaptionVerticalLeft\" style=\"background-image:url(";
        // line 11
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-vertical.gif);\"></span>
\t\t\t\t\t<div class=\"Text\" >Change Password</div>
\t\t\t\t\t<span class=\"CaptionVerticalRight\" style=\"background-image:url(";
        // line 13
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-vertical.gif);\"></span>
\t\t\t\t\t<span class=\"CaptionBorderBottom\" style=\"background-image:url(";
        // line 14
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/table-headline-border.gif);\"></span>
\t\t\t\t\t<span class=\"CaptionEdgeLeftBottom\" style=\"background-image:url(";
        // line 15
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-edge.gif);\"></span>
\t\t\t\t\t<span class=\"CaptionEdgeRightBottom\" style=\"background-image:url(";
        // line 16
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-edge.gif);\"></span>
\t\t\t\t</div>
\t\t\t</div>
\t\t\t<tr>
\t\t\t\t<td>
\t\t\t\t\t<div class=\"InnerTableContainer\">
\t\t\t\t\t\t<table style=\"width:100%;\">
\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t<td class=\"LabelV\">
\t\t\t\t\t\t\t\t\t<span>New Password:</span>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td style=\"width:90%;\">
\t\t\t\t\t\t\t\t\t<input type=\"password\" name=\"newpassword\" size=\"30\" maxlength=\"29\">
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t<td class=\"LabelV\">
\t\t\t\t\t\t\t\t\t<span>New Password Again:</span>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<input type=\"password\" name=\"newpassword2\" size=\"30\" maxlength=\"29\">
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t\t<td class=\"LabelV\">
\t\t\t\t\t\t\t\t\t<span>Current Password:</span>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t<input type=\"password\" name=\"oldpassword\" size=\"30\" maxlength=\"29\">
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t</table>
\t\t\t\t\t</div>
\t\t\t\t</td>
\t\t\t</tr>
\t\t</table>
\t</div>
\t<br/>
\t<table style=\"width:100%;\">
\t\t<tr align=\"center\">
\t\t\t<td>
\t\t\t\t<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
\t\t\t\t\t<tr>
\t\t\t\t\t\t<td style=\"border:0px;\">
\t\t\t\t\t\t\t";
        // line 60
        echo twig_include($this->env, $context, "buttons.submit.html.twig");
        echo "
\t\t\t\t\t\t</td>
\t\t\t\t\t<tr>
\t\t\t\t</table>
\t\t\t</td>
</form>
\t\t\t<td>
\t\t\t\t<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">
\t\t\t\t\t<form action=\"";
        // line 68
        echo twig_escape_filter($this->env, call_user_func_array($this->env->getFunction('getLink')->getCallable(), ["account/manage"]), "html", null, true);
        echo "\" method=\"post\">
\t\t\t\t\t\t<tr>
\t\t\t\t\t\t\t<td style=\"border:0px;\">
\t\t\t\t\t\t\t\t";
        // line 71
        echo twig_include($this->env, $context, "buttons.back.html.twig");
        echo "
\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t</tr>
\t\t\t\t\t</form>
\t\t\t\t</table>
\t\t\t</td>
\t\t</tr>
\t</table>";
    }

    public function getTemplateName()
    {
        return "account.change_password.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  135 => 71,  129 => 68,  118 => 60,  71 => 16,  67 => 15,  63 => 14,  59 => 13,  54 => 11,  50 => 10,  46 => 9,  42 => 8,  34 => 3,  30 => 1,);
    }

    /** @deprecated since 1.27 (to be removed in 2.0). Use getSourceContext() instead */
    public function getSource()
    {
        @trigger_error('The '.__METHOD__.' method is deprecated since version 1.27 and will be removed in 2.0. Use getSourceContext() instead.', E_USER_DEPRECATED);

        return $this->getSourceContext()->getCode();
    }

    public function getSourceContext()
    {
        return new Source("", "account.change_password.html.twig", "/var/www/html/system/templates/account.change_password.html.twig");
    }
}
