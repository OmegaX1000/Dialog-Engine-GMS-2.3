/// @description Insert description here
// You can write your code in this editor

if (gamestate_get() == GameState.Dialog and Dialog_Create == true)
{
	#region //Draw Dialog and Options (if any). 
	#region //If Chatterbox is stopped, don't draw anything.
	if (chatterbox_is_stopped(Text_Chatterbox))
	{
		
	}
	#endregion
	#region //If Chatterbox is still going, then draw the dialog.
	else if (!chatterbox_is_stopped(Text_Chatterbox))
	{
		#region //Draw the Textbox (Top).
		if (Text_Position == true)
		{
			DrawUI_Box(spr_nineslice_box_dialog, 32, 10, 610, 162, 1);
		
			#region //Text (No Portrait)
			if (Portrait_Sprite == -1) //No portrait.
			{
				#region //Text Positions.
				var _text_x = 60;
				var _text_y = 31;
				#endregion
				#region //Draw Dialog.
				Dialog_Element.draw(_text_x, _text_y);
				#endregion
				#region //Draw Options.
				if (Dialog_Element.on_last_page() == true)
				{
					if (chatterbox_get_option_count(Text_Chatterbox))
					{
						var _option_count = chatterbox_get_option_count(Text_Chatterbox);
					
						#region //TextMethod 1: Instant
						if (Text_Method == 0)
						{
							for (var i = 0; i < _option_count; i++)
							{
								var _options = chatterbox_get_option(Text_Chatterbox, i);
								var _dialog_height = Dialog_Element.get_height();
								var _option_height = Dialog_ChoiceElement[i].get_height();
								var _text_x = (204 + ((i % 2) * 192));
								var _text_y = ((95 - (32 * ((_option_count > 2) ? 1 : 0))) - (_option_height - 32) + (32 * floor(i / 2)));
								Dialog_ChoiceElement[i].draw(_text_x, _text_y);

								var _selector_x = (188 + ((Dialog_ChoiceSelector % 2) * 192));
								var _selector_y = ((111 - (32 * ((_option_count > 2) ? 1 : 0))) + (32 * floor(Dialog_ChoiceSelector / 2)));
							
								draw_sprite(spr_frisk_soul_selector_red, 0, _selector_x, _selector_y);
							}
						}
						#endregion
						#region //TextMethod 2: Type-Writter
						else if (Text_Method == 1 and Dialog_ChoiceCreate == true)
						{
							for (var i = 0; i < _option_count; i++)
							{
								var _options = chatterbox_get_option(Text_Chatterbox, i);
								var _dialog_height = Dialog_Element.get_height();
								var _option_height = Dialog_ChoiceElement[i].get_height();
								var _text_x = (204 + ((i % 2) * 192));
								var _text_y = ((95 - (32 * ((_option_count > 2) ? 1 : 0))) - (_option_height - 32) + (32 * floor(i / 2)));
								Dialog_ChoiceElement[i].draw(_text_x, _text_y);

								var _selector_x = (188 + ((Dialog_ChoiceSelector % 2) * 192));
								var _selector_y = ((111 - (32 * ((_option_count > 2) ? 1 : 0))) + (32 * floor(Dialog_ChoiceSelector / 2)));
								var _choice_done = Dialog_ChoiceElement[_option_count - 1].get_typewriter_state();
							
								if (_choice_done == 1)
								{
									if (Dialog_ChoiceSelector_Usable == false)
									{
										Dialog_ChoiceSelector_Usable = true;
									}
								
									draw_sprite(spr_frisk_soul_selector_red, 0, _selector_x, _selector_y);
								}
							}
						}
						#endregion
					}
				}
				#endregion
			}
			#endregion
			#region //Text (With Portrait)
			else if (Portrait_Sprite != -1) //Has portrait.
			{
				#region //Text and Portrait Variables.
				var _portrait_x = 106;
				var _portrait_y = 84;
				var _text_x = 174;
				var _text_y = 31;
				#endregion
				#region //Draw Portrait.
				if (Dialog_Talking == true) //Animate Portrait.
				{
					var _spr_num = sprite_get_number(Portrait_Sprite);
					var _spr_spd = ((sprite_get_speed_type(Portrait_Sprite) == spritespeed_framespergameframe) ? sprite_get_speed(Portrait_Sprite) : (sprite_get_speed(Portrait_Sprite) / game_get_speed(gamespeed_fps)));
					Portrait_Index += (_spr_spd mod _spr_num);
				}
				
				draw_sprite(Portrait_Sprite, Portrait_Index, _portrait_x, _portrait_y);
				#endregion
				#region //Draw Dialog.
				Dialog_Element.draw(_text_x, _text_y);
				#endregion
				#region //Draw Options.
				if (Dialog_Element.on_last_page() == true)
				{
					if (chatterbox_get_option_count(Text_Chatterbox))
					{
						var _option_count = chatterbox_get_option_count(Text_Chatterbox);
					
						#region //TextMethod 1: Instant
						if (Text_Method == 0)
						{
							for (var i = 0; i < _option_count; i++)
							{
								var _options = chatterbox_get_option(Text_Chatterbox, i);
								var _dialog_height = Dialog_Element.get_height();
								var _option_height = Dialog_ChoiceElement[i].get_height();
								var _text_x = (206 + ((i % 2) * 192));
								var _text_y = ((95 - (32 * ((_option_count > 2) ? 1 : 0))) - (_option_height - 32) + (32 * floor(i / 2)));
								Dialog_ChoiceElement[i].draw(_text_x, _text_y);

								var _selector_x = (190 + ((Dialog_ChoiceSelector % 2) * 192));
								var _selector_y = ((111 - (32 * ((_option_count > 2) ? 1 : 0))) + (32 * floor(Dialog_ChoiceSelector / 2)));
								draw_sprite(spr_frisk_soul_selector_red, 0, _selector_x, _selector_y);
							}
						}
						#endregion
						#region //TextMethod 2: Type-Writter
						else if (Text_Method == 1 and Dialog_ChoiceCreate == true)
						{
							for (var i = 0; i < _option_count; i++)
							{
								var _options = chatterbox_get_option(Text_Chatterbox, i);
								var _dialog_height = Dialog_Element.get_height();
								var _option_height = Dialog_ChoiceElement[i].get_height();
								var _text_x = (206 + ((i % 2) * 192));
								var _text_y = ((95 - (32 * ((_option_count > 2) ? 1 : 0))) - (_option_height - 32) + (32 * floor(i / 2)));
								Dialog_ChoiceElement[i].draw(_text_x, _text_y);

								var _selector_x = (190 + ((Dialog_ChoiceSelector % 2) * 192));
								var _selector_y = ((111 - (32 * ((_option_count > 2) ? 1 : 0))) + (32 * floor(Dialog_ChoiceSelector / 2)));
								var _choice_done = Dialog_ChoiceElement[_option_count - 1].get_typewriter_state();
							
								if (_choice_done == 1)
								{
									if (Dialog_ChoiceSelector_Usable == false)
									{
										Dialog_ChoiceSelector_Usable = true;
									}
								
									draw_sprite(spr_frisk_soul_selector_red, 0, _selector_x, _selector_y);
								}
							}
						}
						#endregion
					}
				}
				#endregion
			}
			#endregion
		}
		#endregion
		#region //Draw the Textbox (Bottom).
		else if (Text_Position == false)
		{
			DrawUI_Box(spr_nineslice_box_dialog, 32, 320, 610, 472, 1);
			
			#region //Text (No Portrait)
			if (Portrait_Sprite == -1)
			{
				#region //Text Positions.
				var _text_x = 60;
				var _text_y = 341;
				#endregion
				#region //Draw Dialog.
				Dialog_Element.draw(_text_x, _text_y);
				#endregion
				#region //Draw Options.
				if (Dialog_Element.on_last_page() == true)
				{				
					if (chatterbox_get_option_count(Text_Chatterbox))
					{
						var _option_count = chatterbox_get_option_count(Text_Chatterbox);
					
						#region //TextMethod 1: Instant
						if (Text_Method == 0)
						{
							for (var i = 0; i < _option_count; i++)
							{
								var _options = chatterbox_get_option(Text_Chatterbox, i);
								var _dialog_height = Dialog_Element.get_height();
								var _option_height = Dialog_ChoiceElement[i].get_height();
								var _text_x = (204 + ((i % 2) * 192));
								var _text_y = ((405 - (32 * ((_option_count > 2) ? 1 : 0))) - (_option_height - 32) + (32 * floor(i / 2)));
								Dialog_ChoiceElement[i].draw(_text_x, _text_y);

								var _selector_x = (188 + ((Dialog_ChoiceSelector % 2) * 192));
								var _selector_y = ((421 - (32 * ((_option_count > 2) ? 1 : 0))) + (32 * floor(Dialog_ChoiceSelector / 2)));
								draw_sprite(spr_frisk_soul_selector_red, 0, _selector_x, _selector_y);
							}
						}
						#endregion
						#region //TextMethod 2: Type-Writter
						else if (Text_Method == 1 and Dialog_ChoiceCreate == true)
						{
							for (var i = 0; i < _option_count; i++)
							{
								var _options = chatterbox_get_option(Text_Chatterbox, i);
								var _dialog_height = Dialog_Element.get_height();
								var _option_height = Dialog_ChoiceElement[i].get_height();
								var _text_x = (204 + ((i % 2) * 192));
								var _text_y = ((405 - (32 * ((_option_count > 2) ? 1 : 0))) - (_option_height - 32) + (32 * floor(i / 2)));
								Dialog_ChoiceElement[i].draw(_text_x, _text_y);

								var _selector_x = (188 + ((Dialog_ChoiceSelector % 2) * 192));
								var _selector_y = ((421 - (32 * ((_option_count > 2) ? 1 : 0))) + (32 * floor(Dialog_ChoiceSelector / 2)));
								var _choice_done = Dialog_ChoiceElement[_option_count - 1].get_typewriter_state();
							
								if (_choice_done == 1)
								{
									if (Dialog_ChoiceSelector_Usable == false)
									{
										Dialog_ChoiceSelector_Usable = true;
									}
								
									draw_sprite(spr_frisk_soul_selector_red, 0, _selector_x, _selector_y);
								}
							}
						}
						#endregion
					}
				}
				#endregion
			}
			#endregion
			#region //Text (With Portrait)
			else if (Portrait_Sprite != -1)
			{
				#region //Text and Portrait Variables.
				var _portrait_x = 106;
				var _portrait_y = 394;
				var _text_x = 174;
				var _text_y = 341;
				#endregion
				#region //Draw Portrait.
				if (Dialog_Talking == true) //Animate Portrait.
				{
					var _spr_num = sprite_get_number(Portrait_Sprite);
					var _spr_spd = ((sprite_get_speed_type(Portrait_Sprite) == spritespeed_framespergameframe) ? sprite_get_speed(Portrait_Sprite) : (sprite_get_speed(Portrait_Sprite) / game_get_speed(gamespeed_fps)));
					Portrait_Index += (_spr_spd mod _spr_num);
				}
				
				draw_sprite(Portrait_Sprite, Portrait_Index, _portrait_x, _portrait_y);
				#endregion
				#region //Draw Dialog.
				Dialog_Element.draw(_text_x, _text_y);
				#endregion
				#region //Draw Options
				if (Dialog_Element.on_last_page() == true)
				{
					if (chatterbox_get_option_count(Text_Chatterbox))
					{
						var _option_count = chatterbox_get_option_count(Text_Chatterbox);
					
						#region //TextMethod 1: Instant
						if (Text_Method == 0)
						{
							for (var i = 0; i < _option_count; i++)
							{
								var _options = chatterbox_get_option(Text_Chatterbox, i);
								var _dialog_height = Dialog_Element.get_height();
								var _option_height = Dialog_ChoiceElement[i].get_height();
								var _text_x = (206 + ((i % 2) * 192));
								var _text_y = ((405 - (32 * ((_option_count > 2) ? 1 : 0))) - (_option_height - 32) + (32 * floor(i / 2)));
								Dialog_ChoiceElement[i].draw(_text_x, _text_y);

								var _selector_x = (190 + ((Dialog_ChoiceSelector % 2) * 192));
								var _selector_y = ((421 - (32 * ((_option_count > 2) ? 1 : 0))) + (32 * floor(Dialog_ChoiceSelector / 2)));
								draw_sprite(spr_frisk_soul_selector_red, 0, _selector_x, _selector_y);
							}
						}
						#endregion
						#region //TextMethod 2: Type-Writter
						else if (Text_Method == 1 and Dialog_ChoiceCreate == true)
						{
							for (var i = 0; i < _option_count; i++)
							{
								var _options = chatterbox_get_option(Text_Chatterbox, i);
								var _dialog_height = Dialog_Element.get_height();
								var _option_height = Dialog_ChoiceElement[i].get_height();
								var _text_x = (206 + ((i % 2) * 192));
								var _text_y = ((405 - (32 * ((_option_count > 2) ? 1 : 0))) - (_option_height - 32) + (32 * floor(i / 2)));
								Dialog_ChoiceElement[i].draw(_text_x, _text_y);

								var _selector_x = (190 + ((Dialog_ChoiceSelector % 2) * 192));
								var _selector_y = ((421 - (32 * ((_option_count > 2) ? 1 : 0))) + (32 * floor(Dialog_ChoiceSelector / 2)));
								var _choice_done = Dialog_ChoiceElement[_option_count - 1].get_typewriter_state();
							
								if (_choice_done == 1)
								{
									if (Dialog_ChoiceSelector_Usable == false)
									{
										Dialog_ChoiceSelector_Usable = true;
									}
								
									draw_sprite(spr_frisk_soul_selector_red, 0, _selector_x, _selector_y);
								}
							}
						}
						#endregion
					}
				}
				#endregion
			}
			#endregion
		}
		#endregion
	}
	#endregion
	#endregion
}