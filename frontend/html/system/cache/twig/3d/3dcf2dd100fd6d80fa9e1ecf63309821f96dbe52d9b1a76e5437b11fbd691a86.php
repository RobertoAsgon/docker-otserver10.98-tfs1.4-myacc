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

/* account.lost.form.html.twig */
class __TwigTemplate_ffac3014a53b26a75cca20d1dd03a59f84b30bec37ebece34dff2d22070672cb extends \Twig\Template
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
        echo "The Lost Account Interface can help you to get back your account name and password. Please enter your character name and select what you want to do.<br/>
<form action=\"?subtopic=lostaccount&action=step1\" method=post>
\t<input type=\"hidden\" name=\"character\" value=\"\">
\t<table cellspacing=\"1\" cellpadding=\"4\" border=\"0\" width=\"100%\">
\t\t<tr>
\t\t\t<td bgcolor=\"";
        // line 6
        echo twig_escape_filter($this->env, $this->getAttribute(($context["config"] ?? null), "vdarkborder", []), "html", null, true);
        echo "\" class=\"white\"><b>Please enter your character name</b></td>
\t\t</tr>
\t\t<tr>
\t\t\t<td bgcolor=\"";
        // line 9
        echo twig_escape_filter($this->env, $this->getAttribute(($context["config"] ?? null), "darkborder", []), "html", null, true);
        echo "\">
\t\t\t\t<input type=\"text\" name=\"nick\" size=\"40\" autofocus/><br>
\t\t\t</td>
\t\t</tr>
\t</table>
\t<table cellspacing=\"1\" cellpadding=\"4\" border=\"0\" width=\"100%\">
\t\t<tr>
\t\t\t<td bgcolor=\"";
        // line 16
        echo twig_escape_filter($this->env, $this->getAttribute(($context["config"] ?? null), "vdarkborder", []), "html", null, true);
        echo "\" class=\"white\"><b>What do you want?</b></td>
\t\t</tr>
\t\t<tr>
\t\t\t<td bgcolor=\"";
        // line 19
        echo twig_escape_filter($this->env, $this->getAttribute(($context["config"] ?? null), "darkborder", []), "html", null, true);
        echo "\">
\t\t\t\t<input type=\"radio\" name=\"action_type\" id=\"action_type_email\" value=\"email\">
\t\t\t\t<label for=\"action_type_email\"> Send me new password and my account name to account e-mail adress.</label><br/>
\t\t\t\t<input type=radio name=\"action_type\" id=\"action_type_key\" value=\"reckey\">
\t\t\t\t<label for=\"action_type_key\"> I got <b>recovery key</b> and want set new password and e-mail adress to my account.</label><br/>
\t\t\t</td>
\t\t</tr>
\t</table>
\t<br/>
\t<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">
\t\t<tr>
\t\t\t<td align=\"center\">
\t\t\t\t";
        // line 31
        echo twig_include($this->env, $context, "buttons.submit.html.twig");
        echo "
\t\t\t</td>
\t\t</tr>
\t</table>
</form>";
    }

    public function getTemplateName()
    {
        return "account.lost.form.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  74 => 31,  59 => 19,  53 => 16,  43 => 9,  37 => 6,  30 => 1,);
    }

    /** @deprecated since 1.27 (to be removed in 2.0). Use getSourceContext() instead */
    public function getSource()
    {
        @trigger_error('The '.__METHOD__.' method is deprecated since version 1.27 and will be removed in 2.0. Use getSourceContext() instead.', E_USER_DEPRECATED);

        return $this->getSourceContext()->getCode();
    }

    public function getSourceContext()
    {
        return new Source("", "account.lost.form.html.twig", "/var/www/html/system/templates/account.lost.form.html.twig");
    }
}
