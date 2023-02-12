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

/* team.html.twig */
class __TwigTemplate_d2a74cc4e1f19fbc8414cae03f92d9f6c7cebb47347678bd26ba58ec5526f8af extends \Twig\Template
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
        echo "<div class=\"TableContainer\">
\t<div class=\"CaptionContainer\">
\t\t<div class=\"CaptionInnerContainer\">
\t\t\t<span class=\"CaptionEdgeLeftTop\" style=\"background-image:url(";
        // line 4
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-edge.gif);\"></span>
\t\t\t<span class=\"CaptionEdgeRightTop\" style=\"background-image:url(";
        // line 5
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-edge.gif);\"></span>
\t\t\t<span class=\"CaptionBorderTop\" style=\"background-image:url(";
        // line 6
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/table-headline-border.gif);\"></span>
\t\t\t<span class=\"CaptionVerticalLeft\" style=\"background-image:url(";
        // line 7
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-vertical.gif);\"></span>
\t\t\t<div class=\"Text\" >Support in game</div>
\t\t\t<span class=\"CaptionVerticalRight\" style=\"background-image:url(";
        // line 9
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-vertical.gif);\"></span>
\t\t\t<span class=\"CaptionBorderBottom\" style=\"background-image:url(";
        // line 10
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/table-headline-border.gif);\"></span>
\t\t\t<span class=\"CaptionEdgeLeftBottom\" style=\"background-image:url(";
        // line 11
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-edge.gif);\"></span>
\t\t\t<span class=\"CaptionEdgeRightBottom\" style=\"background-image:url(";
        // line 12
        echo twig_escape_filter($this->env, ($context["template_path"] ?? null), "html", null, true);
        echo "/images/content/box-frame-edge.gif);\"></span>
\t\t</div>
\t</div>
\t<table class=\"Table1\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: ";
        // line 15
        echo twig_escape_filter($this->env, $this->getAttribute(($context["config"] ?? null), "lightborder", []), "html", null, true);
        echo "\">
\t\t<tr>
\t\t\t<td>
\t\t\t\t<div class=\"InnerTableContainer\">
\t\t\t\t\t";
        // line 19
        $context["i"] = 0;
        // line 20
        echo "\t\t\t\t\t";
        if (($this->getAttribute(($context["config"] ?? null), "team_style", []) == 1)) {
            // line 21
            echo "
\t\t\t\t\t\t<table border=\"0\" cellpadding=\"4\" cellspacing=\"1\" width=\"100%\">
\t\t\t\t\t\t\t<tr bgcolor=\"";
            // line 23
            echo twig_escape_filter($this->env, $this->getAttribute(($context["config"] ?? null), "vdarkborder", []), "html", null, true);
            echo "\">
\t\t\t\t\t\t\t\t<td width=\"10%\" class=\"white\">
\t\t\t\t\t\t\t\t\t<b>Group</b>
\t\t\t\t\t\t\t\t</td>

\t\t\t\t\t\t\t\t";
            // line 28
            if ($this->getAttribute(($context["config"] ?? null), "team_display_outfit", [])) {
                // line 29
                echo "\t\t\t\t\t\t\t\t<td width=\"5%\" class=\"white\">
\t\t\t\t\t\t\t\t\t<b>Outfit</b>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t";
            }
            // line 33
            echo "
\t\t\t\t\t\t\t\t<td width=\"40%\" class=\"white\">
\t\t\t\t\t\t\t\t\t<b>Name</b>
\t\t\t\t\t\t\t\t</td>

\t\t\t\t\t\t\t\t";
            // line 38
            if ($this->getAttribute(($context["config"] ?? null), "team_display_status", [])) {
                // line 39
                echo "\t\t\t\t\t\t\t\t<td class=\"white\">
\t\t\t\t\t\t\t\t\t<b>Status</b>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t";
            }
            // line 43
            echo "
\t\t\t\t\t\t\t\t";
            // line 44
            if (($this->getAttribute(($context["config"] ?? null), "multiworld", []) || $this->getAttribute(($context["config"] ?? null), "team_display_world", []))) {
                // line 45
                echo "\t\t\t\t\t\t\t\t<td class=\"white\">
\t\t\t\t\t\t\t\t\t<b>World</b>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t";
            }
            // line 49
            echo "
\t\t\t\t\t\t\t\t";
            // line 50
            if ($this->getAttribute(($context["config"] ?? null), "team_display_lastlogin", [])) {
                // line 51
                echo "\t\t\t\t\t\t\t\t<td class=\"white\">
\t\t\t\t\t\t\t\t\t<b>Last login</b>
\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t";
            }
            // line 55
            echo "\t\t\t\t\t\t\t</tr>

\t\t\t\t\t\t\t";
            // line 57
            $context['_parent'] = $context;
            $context['_seq'] = twig_ensure_traversable(twig_reverse_filter($this->env, ($context["groupmember"] ?? null)));
            foreach ($context['_seq'] as $context["_key"] => $context["group"]) {
                // line 58
                echo "\t\t\t\t\t\t\t\t";
                if ( !twig_test_empty($this->getAttribute($context["group"], "members", []))) {
                    // line 59
                    echo "\t\t\t\t\t\t\t\t\t";
                    $context['_parent'] = $context;
                    $context['_seq'] = twig_ensure_traversable(twig_reverse_filter($this->env, $this->getAttribute($context["group"], "members", [])));
                    foreach ($context['_seq'] as $context["_key"] => $context["member"]) {
                        // line 60
                        echo "\t\t\t\t\t\t\t\t\t";
                        $context["i"] = (($context["i"] ?? null) + 1);
                        // line 61
                        echo "\t\t\t\t\t\t\t\t\t<tr bgcolor=\"";
                        echo twig_escape_filter($this->env, call_user_func_array($this->env->getFunction('getStyle')->getCallable(), [($context["i"] ?? null)]), "html", null, true);
                        echo "\" style=\"height: 32px;\">
\t\t\t\t\t\t\t\t\t\t<td>";
                        // line 62
                        echo twig_escape_filter($this->env, twig_capitalize_string_filter($this->env, $this->getAttribute($context["group"], "group_name", [])), "html", null, true);
                        echo "</td>

\t\t\t\t\t\t\t\t\t\t";
                        // line 64
                        if ($this->getAttribute(($context["config"] ?? null), "team_display_outfit", [])) {
                            // line 65
                            echo "\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<img style=\"position: absolute; margin-top: ";
                            // line 66
                            if (twig_in_filter($this->getAttribute($this->getAttribute($context["member"], "player", []), "looktype", []), [0 => 75, 1 => 266, 2 => 302])) {
                                echo "-16px;margin-left:-0px;";
                            } else {
                                echo " -45px; margin-left: -30px;";
                            }
                            echo "\" src=\"";
                            echo twig_escape_filter($this->env, $this->getAttribute($context["member"], "outfit", []), "html", null, true);
                            echo "\" alt=\"player outfit\"/>
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t";
                        }
                        // line 69
                        echo "
\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t";
                        // line 71
                        if ($this->getAttribute(($context["config"] ?? null), "account_country", [])) {
                            // line 72
                            echo "\t\t\t\t\t\t\t\t\t\t\t\t";
                            echo $this->getAttribute($context["member"], "flag_image", []);
                            echo "
\t\t\t\t\t\t\t\t\t\t\t";
                        }
                        // line 74
                        echo "\t\t\t\t\t\t\t\t\t\t\t";
                        echo $this->getAttribute($context["member"], "link", []);
                        echo "
\t\t\t\t\t\t\t\t\t\t</td>

\t\t\t\t\t\t\t\t\t\t";
                        // line 77
                        if ($this->getAttribute(($context["config"] ?? null), "team_display_status", [])) {
                            // line 78
                            echo "\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t";
                            // line 79
                            if ($this->getAttribute($context["member"], "status", [])) {
                                // line 80
                                echo "\t\t\t\t\t\t\t\t\t\t\t\t<span style=\"color: green\"><b>Online</b></span>
\t\t\t\t\t\t\t\t\t\t\t";
                            } else {
                                // line 82
                                echo "\t\t\t\t\t\t\t\t\t\t\t\t<span style=\"color: red\"><b>Offline</b></span>
\t\t\t\t\t\t\t\t\t\t\t";
                            }
                            // line 84
                            echo "\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t";
                        }
                        // line 86
                        echo "
\t\t\t\t\t\t\t\t\t\t";
                        // line 87
                        if (($this->getAttribute(($context["config"] ?? null), "multiworld", []) || $this->getAttribute(($context["config"] ?? null), "team_display_world", []))) {
                            // line 88
                            echo "\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<span><b>";
                            // line 89
                            echo twig_escape_filter($this->env, $this->getAttribute($context["member"], "world_name", []), "html", null, true);
                            echo "</b></span>
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t";
                        }
                        // line 92
                        echo "
\t\t\t\t\t\t\t\t\t\t";
                        // line 93
                        if ($this->getAttribute(($context["config"] ?? null), "team_display_lastlogin", [])) {
                            // line 94
                            echo "\t\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t\t<span>";
                            // line 95
                            echo twig_escape_filter($this->env, $this->getAttribute($context["member"], "last_login", []), "html", null, true);
                            echo "</span>
\t\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t\t";
                        }
                        // line 98
                        echo "\t\t\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t\t\t";
                    }
                    $_parent = $context['_parent'];
                    unset($context['_seq'], $context['_iterated'], $context['_key'], $context['member'], $context['_parent'], $context['loop']);
                    $context = array_intersect_key($context, $_parent) + $_parent;
                    // line 100
                    echo "\t\t\t\t\t\t\t\t";
                }
                // line 101
                echo "\t\t\t\t\t\t\t";
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['_key'], $context['group'], $context['_parent'], $context['loop']);
            $context = array_intersect_key($context, $_parent) + $_parent;
            // line 102
            echo "\t\t\t\t\t\t</table>
\t\t\t\t\t";
        } elseif (($this->getAttribute(        // line 103
($context["config"] ?? null), "team_style", []) == 2)) {
            // line 104
            echo "\t\t\t\t\t\t";
            $context['_parent'] = $context;
            $context['_seq'] = twig_ensure_traversable(twig_reverse_filter($this->env, ($context["groupmember"] ?? null)));
            foreach ($context['_seq'] as $context["_key"] => $context["group"]) {
                // line 105
                echo "\t\t\t\t\t\t\t";
                if ( !twig_test_empty($this->getAttribute($context["group"], "members", []))) {
                    // line 106
                    echo "\t\t\t\t\t\t\t<div style=\"text-align:center\"><h2>";
                    echo twig_escape_filter($this->env, twig_capitalize_string_filter($this->env, $this->getAttribute($context["group"], "group_name", [])), "html", null, true);
                    echo "</h2></div>

\t\t\t\t\t\t\t<table cellspacing=\"1\" cellpadding=\"4\" border=\"0\" width=\"100%\">
\t\t\t\t\t\t\t\t<tr bgcolor=\"";
                    // line 109
                    echo twig_escape_filter($this->env, $this->getAttribute(($context["config"] ?? null), "vdarkborder", []), "html", null, true);
                    echo "\">
\t\t\t\t\t\t\t\t\t";
                    // line 110
                    if ($this->getAttribute(($context["config"] ?? null), "team_display_outfit", [])) {
                        // line 111
                        echo "\t\t\t\t\t\t\t\t\t<td width=\"5%\" class=\"white\">
\t\t\t\t\t\t\t\t\t\t<b>Outfit</b>
\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t";
                    }
                    // line 115
                    echo "
\t\t\t\t\t\t\t\t\t<td width=\"40%\" class=\"white\">
\t\t\t\t\t\t\t\t\t\t<b>Name</b>
\t\t\t\t\t\t\t\t\t</td>

\t\t\t\t\t\t\t\t\t";
                    // line 120
                    if ($this->getAttribute(($context["config"] ?? null), "team_display_status", [])) {
                        // line 121
                        echo "\t\t\t\t\t\t\t\t\t<td class=\"white\">
\t\t\t\t\t\t\t\t\t\t<b>Status</b>
\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t";
                    }
                    // line 125
                    echo "
\t\t\t\t\t\t\t\t\t";
                    // line 126
                    if (($this->getAttribute(($context["config"] ?? null), "multiworld", []) || $this->getAttribute(($context["config"] ?? null), "team_display_world", []))) {
                        // line 127
                        echo "\t\t\t\t\t\t\t\t\t<td class=\"white\">
\t\t\t\t\t\t\t\t\t\t<b>World</b>
\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t";
                    }
                    // line 131
                    echo "
\t\t\t\t\t\t\t\t\t";
                    // line 132
                    if ($this->getAttribute(($context["config"] ?? null), "team_display_lastlogin", [])) {
                        // line 133
                        echo "\t\t\t\t\t\t\t\t\t<td class=\"white\">
\t\t\t\t\t\t\t\t\t\t<b>Last login</b>
\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t";
                    }
                    // line 137
                    echo "\t\t\t\t\t\t\t\t</tr>

\t\t\t\t\t\t\t\t";
                    // line 139
                    $context['_parent'] = $context;
                    $context['_seq'] = twig_ensure_traversable($this->getAttribute($context["group"], "members", []));
                    foreach ($context['_seq'] as $context["_key"] => $context["member"]) {
                        // line 140
                        echo "\t\t\t\t\t\t\t\t";
                        $context["i"] = (($context["i"] ?? null) + 1);
                        // line 141
                        echo "\t\t\t\t\t\t\t\t\t<tr bgcolor=\"";
                        echo twig_escape_filter($this->env, call_user_func_array($this->env->getFunction('getStyle')->getCallable(), [($context["i"] ?? null)]), "html", null, true);
                        echo "\" style=\"height: 32px;\">
\t\t\t\t\t\t\t\t\t";
                        // line 142
                        if ($this->getAttribute(($context["config"] ?? null), "team_display_outfit", [])) {
                            // line 143
                            echo "\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t<img style=\"position: absolute; margin-top: ";
                            // line 144
                            if (twig_in_filter($this->getAttribute($this->getAttribute($context["member"], "player", []), "looktype", []), [0 => 75, 1 => 266, 2 => 302])) {
                                echo "-16px;margin-left:-0px;";
                            } else {
                                echo " -45px; margin-left: -30px;";
                            }
                            echo "\" src=\"";
                            echo twig_escape_filter($this->env, $this->getAttribute($context["member"], "outfit", []), "html", null, true);
                            echo "\" alt=\"player outfit\"/>
\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t";
                        }
                        // line 147
                        echo "
\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t";
                        // line 149
                        if ($this->getAttribute(($context["config"] ?? null), "account_country", [])) {
                            // line 150
                            echo "\t\t\t\t\t\t\t\t\t\t\t";
                            echo $this->getAttribute($context["member"], "flag_image", []);
                            echo "
\t\t\t\t\t\t\t\t\t\t";
                        }
                        // line 152
                        echo "\t\t\t\t\t\t\t\t\t\t";
                        echo $this->getAttribute($context["member"], "link", []);
                        echo "
\t\t\t\t\t\t\t\t\t</td>

\t\t\t\t\t\t\t\t\t";
                        // line 155
                        if ($this->getAttribute(($context["config"] ?? null), "team_display_status", [])) {
                            // line 156
                            echo "\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t";
                            // line 157
                            if ($this->getAttribute($context["member"], "status", [])) {
                                // line 158
                                echo "\t\t\t\t\t\t\t\t\t\t\t<span style=\"color: green\"><b>Online</b></span>
\t\t\t\t\t\t\t\t\t\t";
                            } else {
                                // line 160
                                echo "\t\t\t\t\t\t\t\t\t\t\t<span style=\"color: red\"><b>Offline</b></span>
\t\t\t\t\t\t\t\t\t\t";
                            }
                            // line 162
                            echo "\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t";
                        }
                        // line 164
                        echo "
\t\t\t\t\t\t\t\t\t";
                        // line 165
                        if (($this->getAttribute(($context["config"] ?? null), "multiworld", []) || $this->getAttribute(($context["config"] ?? null), "team_display_world", []))) {
                            // line 166
                            echo "\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t<span><b>";
                            // line 167
                            echo twig_escape_filter($this->env, $this->getAttribute($context["member"], "world_name", []), "html", null, true);
                            echo "</b></span>
\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t";
                        }
                        // line 170
                        echo "
\t\t\t\t\t\t\t\t\t";
                        // line 171
                        if ($this->getAttribute(($context["config"] ?? null), "team_display_lastlogin", [])) {
                            // line 172
                            echo "\t\t\t\t\t\t\t\t\t<td>
\t\t\t\t\t\t\t\t\t\t<span>";
                            // line 173
                            echo twig_escape_filter($this->env, $this->getAttribute($context["member"], "last_login", []), "html", null, true);
                            echo "</span>
\t\t\t\t\t\t\t\t\t</td>
\t\t\t\t\t\t\t\t\t";
                        }
                        // line 176
                        echo "\t\t\t\t\t\t\t\t</tr>
\t\t\t\t\t\t\t\t";
                    }
                    $_parent = $context['_parent'];
                    unset($context['_seq'], $context['_iterated'], $context['_key'], $context['member'], $context['_parent'], $context['loop']);
                    $context = array_intersect_key($context, $_parent) + $_parent;
                    // line 178
                    echo "\t\t\t\t\t\t\t</table>
\t\t\t\t\t\t\t";
                }
                // line 180
                echo "\t\t\t\t\t\t";
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['_key'], $context['group'], $context['_parent'], $context['loop']);
            $context = array_intersect_key($context, $_parent) + $_parent;
            // line 181
            echo "\t\t\t\t\t";
        }
        // line 182
        echo "\t\t\t\t</div>
\t\t\t</td>
\t\t</tr>
\t</table>
</div>
";
    }

    public function getTemplateName()
    {
        return "team.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  455 => 182,  452 => 181,  446 => 180,  442 => 178,  435 => 176,  429 => 173,  426 => 172,  424 => 171,  421 => 170,  415 => 167,  412 => 166,  410 => 165,  407 => 164,  403 => 162,  399 => 160,  395 => 158,  393 => 157,  390 => 156,  388 => 155,  381 => 152,  375 => 150,  373 => 149,  369 => 147,  357 => 144,  354 => 143,  352 => 142,  347 => 141,  344 => 140,  340 => 139,  336 => 137,  330 => 133,  328 => 132,  325 => 131,  319 => 127,  317 => 126,  314 => 125,  308 => 121,  306 => 120,  299 => 115,  293 => 111,  291 => 110,  287 => 109,  280 => 106,  277 => 105,  272 => 104,  270 => 103,  267 => 102,  261 => 101,  258 => 100,  251 => 98,  245 => 95,  242 => 94,  240 => 93,  237 => 92,  231 => 89,  228 => 88,  226 => 87,  223 => 86,  219 => 84,  215 => 82,  211 => 80,  209 => 79,  206 => 78,  204 => 77,  197 => 74,  191 => 72,  189 => 71,  185 => 69,  173 => 66,  170 => 65,  168 => 64,  163 => 62,  158 => 61,  155 => 60,  150 => 59,  147 => 58,  143 => 57,  139 => 55,  133 => 51,  131 => 50,  128 => 49,  122 => 45,  120 => 44,  117 => 43,  111 => 39,  109 => 38,  102 => 33,  96 => 29,  94 => 28,  86 => 23,  82 => 21,  79 => 20,  77 => 19,  70 => 15,  64 => 12,  60 => 11,  56 => 10,  52 => 9,  47 => 7,  43 => 6,  39 => 5,  35 => 4,  30 => 1,);
    }

    /** @deprecated since 1.27 (to be removed in 2.0). Use getSourceContext() instead */
    public function getSource()
    {
        @trigger_error('The '.__METHOD__.' method is deprecated since version 1.27 and will be removed in 2.0. Use getSourceContext() instead.', E_USER_DEPRECATED);

        return $this->getSourceContext()->getCode();
    }

    public function getSourceContext()
    {
        return new Source("", "team.html.twig", "/var/www/html/system/templates/team.html.twig");
    }
}
