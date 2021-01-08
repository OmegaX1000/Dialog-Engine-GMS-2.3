/// @description Insert description here
// You can write your code in this editor

if (gamestate_get() == GameState.Dialog and Dialog_Create == false)
{
	#region //Initalize Dialog.	
	#region //TextMethod 1: Instant
	if (Text_Method == 0)
	{
		#region //Load in the JSON/Yarn File.
		if (chatterbox_is_loaded(Chatterbox_File) == false)
		{
			chatterbox_load(Chatterbox_File); 
		}
		#endregion
		#region //Create the Chatterbox.
		if (is_chatterbox(Text_Chatterbox) == false)
		{
			Text_Chatterbox = chatterbox_create(Chatterbox_File, true); //Create a Chatterbox.
		}
		#endregion
		#region //Head towards the Starting Node for the first page of dialog.
		if (Dialog_StartNode_Init == false)
		{
			chatterbox_goto(Text_Chatterbox, Chatterbox_StartNode, Chatterbox_File); //Goes to the starting node.
			Dialog_StartNode_Init = true;
		}
		#endregion
		#region //Load Chatterbox Dialog into scribble's cache and set up scribble warping.
		for (var i = 0; i < chatterbox_get_content_count(Text_Chatterbox); i++)
		{
			var _text_string = chatterbox_get_content(Text_Chatterbox, i);
			Dialog_Element = scribble(_text_string); //Put the dialog in cache.
			Dialog_Element.starting_format(Text_Font, Text_Color);
			
			#region //If the Dialog dosen't have a portrait sprite.
			if (Portrait_Sprite == -1)
			{
				Dialog_Element.wrap(550, 96); //Make sure that the text dosen't go past the textbox.
			}
			#endregion
			#region //If the Dialog does have a portrait sprite.
			else if (Portrait_Sprite != -1)
			{
				Dialog_Element.wrap(436, 96);
			}
			#endregion
		}
		#endregion

		Dialog_Create = true; //Move on to the Dialog Behavior.
	}
	#endregion
	#region //TextMethod 2: Type-Writter
	else if (Text_Method == 1)
	{
		#region //Load in the JSON/Yarn File.
		if (chatterbox_is_loaded(Chatterbox_File) == false)
		{
			chatterbox_load(Chatterbox_File); 
		}
		#endregion
		#region //Create the Chatterbox.
		if (is_chatterbox(Text_Chatterbox) == false)
		{
			Text_Chatterbox = chatterbox_create(Chatterbox_File, true); //Create a Chatterbox.
		}
		#endregion
		#region //Head towards the Starting Node for the first page of dialog.
		if (Dialog_StartNode_Init == false)
		{
			chatterbox_goto(Text_Chatterbox, Chatterbox_StartNode, Chatterbox_File); //Goes to the starting node.
			Dialog_StartNode_Init = true;
		}
		#endregion
		#region //Load Chatterbox Dialog into scribble's cache and set up scribble warping.
		for (var i = 0; i < chatterbox_get_content_count(Text_Chatterbox); i++)
		{
			var _text_string = chatterbox_get_content(Text_Chatterbox, i);
			Dialog_Element = scribble(_text_string); //Put the dialog in cache.
			Dialog_Element.starting_format(Text_Font, Text_Color);
			
			#region //If the Dialog dosen't have a portrait sprite.
			if (Portrait_Sprite == -1)
			{
				Dialog_Element.wrap(550, 96); //Make sure that the text dosen't go past the textbox.
			}
			#endregion
			#region //If the Dialog does have a portrait sprite.
			else if (Portrait_Sprite != -1)
			{
				Dialog_Element.wrap(436, 96);
			}
			#endregion
		}
		#endregion
		#region //Finish Setting Up Scribble.
		Dialog_Element.typewriter_in(Text_Speed, 0); //Initalize Typewriter effect.
		Dialog_Element.typewriter_sound_per_char(Text_Voice, 1, 1); //Initalize the Typewriter SFX.
		Dialog_Talking = true; //Animate the current overworld character that is talking (and portrait if there is one).	
		Dialog_Create = true; //Move on to the Dialog Behavior.
		#endregion
	}
	#endregion
	#region //TextMethof 3: Fade-In
	else if (Text_Method == 2)
	{
		Dialog_Create = true;
	}
	#endregion
	#endregion
}
else if (gamestate_get() == GameState.Dialog and Dialog_Create == true)
{
	#region //Dialog Behavior
	#region //Instant Dialog
	if (Text_Method == 0) 
	{
		#region //If Chatterbox is stopped, don't do anything.
		if (chatterbox_is_stopped(Text_Chatterbox))
		{
			instance_destroy(id, true);
		}
		#endregion
		#region //If Chatterbox is still going, do stuff.
		else if (chatterbox_is_waiting(Text_Chatterbox))
		{			
			#region //If the dialog element is on the last page.
			if (Dialog_Element.on_last_page() == true)
			{
				#region //Scrolling through the pages (Chatterbox) of dialog.
				if (input_check_press(Controls.ACTION) and Dialog_Canskip == true)
				{			
					chatterbox_continue(Text_Chatterbox);
					
					#region //Load Chatterbox Dialog into scribble's cache.
					for (var i = 0; i < chatterbox_get_content_count(Text_Chatterbox); i++)
					{
						var _text_string = chatterbox_get_content(Text_Chatterbox, i);
						Dialog_Element = scribble(_text_string); //Put the dialog in cache.
						Dialog_Element.starting_format(Text_Font, Text_Color);
			
						#region //If the Dialog dosen't have a portrait sprite.
						if (Portrait_Sprite == -1)
						{
							Dialog_Element.wrap(550, 96); //Make sure that the text dosen't go past the textbox.
						}
						#endregion
						#region //If the Dialog does have a portrait sprite.
						else if (Portrait_Sprite != -1)
						{
							Dialog_Element.wrap(436, 96);
						}
						#endregion
					}
					#endregion
				}
				#endregion
			}
			#endregion
			#region //If the dialog element still have more pages to see.
			else if (Dialog_Element.on_last_page() == false)
			{
				#region //Let Scribble go to the next page if there is more dialog that didn't fit in the textbox.
				if (input_check_press(Controls.ACTION) and Dialog_Canskip == true)
				{
					var _current_page = Dialog_Element.get_page(); //Current Page.
					var _new_page = _current_page + 1; //New Page.	
					Dialog_Element.page(_new_page); //Move to the Next Page.
				}
				#endregion
			}
			#endregion
		}
		#endregion
		#region //If chatterbox is not waiting then we have options we neeed to select.
		else if (chatterbox_get_option_count(Text_Chatterbox))
		{	
			#region //If scribble is on the last page then we can choose options.
			if (Dialog_Element.on_last_page() == true)
			{
				#region //Moving the Selector.
				#region //Up
				if (input_check_press(Controls.UP))
				{
					if (Dialog_ChoiceSelector == 0 or Dialog_ChoiceSelector == 1)
					{
						if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector + 2))
						{
							Dialog_ChoiceSelector += 2;
						}
					}
					else
					{
						if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector - 2))
						{
							Dialog_ChoiceSelector -= 2;
						}
					}
				}
				#endregion
				#region //Down
				else if (input_check_press(Controls.DOWN))
				{
					if (Dialog_ChoiceSelector == 2 or Dialog_ChoiceSelector == 3)
					{
						if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector - 2))
						{
							Dialog_ChoiceSelector -= 2;
						}
					}
					else
					{
						if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector + 2))
						{
							Dialog_ChoiceSelector += 2;
						}
					}
				}
				#endregion
				#region //Left
				else if (input_check_press(Controls.LEFT))
				{
					if (Dialog_ChoiceSelector == 0 or Dialog_ChoiceSelector == 2)
					{
						if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector + 1))
						{
							Dialog_ChoiceSelector += 1;
						}
					}
					else
					{
					
						Dialog_ChoiceSelector -= 1;
					}
				}
				#endregion
				#region //Right
				else if (input_check_press(Controls.RIGHT))
				{
					if (Dialog_ChoiceSelector == 1 or Dialog_ChoiceSelector == 3)
					{
						Dialog_ChoiceSelector -= 1;
					}
					else
					{
						if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector + 1))
						{
							Dialog_ChoiceSelector += 1;
						}
					}
				}
				#endregion
				#endregion
				#region //Selecting a choice.
				else if (input_check_press(Controls.ACTION))
				{
					chatterbox_select(Text_Chatterbox, Dialog_ChoiceSelector);
				
					#region //Load Chatterbox Dialog into scribble's cache.
					for (var i = 0; i < chatterbox_get_content_count(Text_Chatterbox); i++)
					{
						var _text_string = chatterbox_get_content(Text_Chatterbox, i);
						Dialog_Element = scribble(_text_string); //Put the dialog in cache.
						Dialog_Element.starting_format(Text_Font, Text_Color);
			
						#region //If the Dialog dosen't have a portrait sprite.
						if (Portrait_Sprite == -1)
						{
							Dialog_Element.wrap(550, 96); //Make sure that the text dosen't go past the textbox.
						}
						#endregion
						#region //If the Dialog does have a portrait sprite.
						else if (Portrait_Sprite != -1)
						{
							Dialog_Element.wrap(436, 96);
						}
						#endregion
					}
					#endregion
				
					Dialog_ChoiceSelector = 0;
				}
				#endregion
			}
			#endregion
		}
		#endregion
	}
	#endregion
	#region //Typed-out Dialog
	else if (Text_Method == 1) 
	{
		var _done = Dialog_Element.get_typewriter_state(); //Get the current state of the text.
		
		#region //If Chatterbox is stopped, don't do anything.
		if (chatterbox_is_stopped(Text_Chatterbox))
		{
			instance_destroy(id, true);
		}
		#endregion
		#region //Scribble has finished fading in the text.
		else if (_done == 1)
		{
			#region //Stop Animating the Portraits.
			if (Dialog_Talking == true)
			{
				Dialog_Talking = false;
			}
			#endregion
			#region //If Chatterbox is still going, do stuff.
			if (chatterbox_is_waiting(Text_Chatterbox))
			{
				#region //If the dialog element is on the last page.
				if (Dialog_Element.on_last_page() == true)
				{
					#region //Scrolling through the pages of dialog.
					if ((input_check_press(Controls.ACTION) and Dialog_Canskip == true) or Dialog_Next == true)
					{			
						chatterbox_continue(Text_Chatterbox);
					
						#region //Load Chatterbox Dialog into scribble's cache.
						for (var i = 0; i < chatterbox_get_content_count(Text_Chatterbox); i++)
						{
							var _text_string = chatterbox_get_content(Text_Chatterbox, i);
							Dialog_Element = scribble(_text_string); //Put the dialog in cache.
							Dialog_Element.starting_format(Text_Font, Text_Color);
			
							#region //If the Dialog dosen't have a portrait sprite.
							if (Portrait_Sprite == -1)
							{
								Dialog_Element.wrap(550, 96); //Make sure that the text dosen't go past the textbox.
							}
							#endregion
							#region //If the Dialog does have a portrait sprite.
							else if (Portrait_Sprite != -1)
							{
								Dialog_Element.wrap(436, 96);
							}
							#endregion
						}
						#endregion
						#region //Setup The Typewritter Effect and SFX and continue the Dialog.
						Dialog_Element.typewriter_in(Text_Speed, 0); //Initalize Typewriter effect.
						Dialog_Element.typewriter_sound_per_char(Text_Voice, 1, 1); //Initalize the Typewriter SFX.
						Dialog_Talking = true; //Used for animating portraits and overworld characters.
						Dialog_Canskip = true; //Determines if the text can be skipped by player input.
						Dialog_Next = false; //If true then the dialog will advance on its own.
						#endregion
					}
					#endregion
				}
				#endregion
				#region //If the dialog element still have more pages to see.
				else if (Dialog_Element.on_last_page() == false)
				{
					#region //Let Scribble go to the next page if there is more dialog that didn't fit in the textbox.
					if (input_check_press(Controls.ACTION) and Dialog_Canskip == true)
					{
						var _current_page = Dialog_Element.get_page();
						var _new_page = _current_page + 1; //New Page.	
						Dialog_Element.page(_new_page); //Move to the Next Page.
					}
					#endregion
				}
				#endregion
			}
			#endregion
			#region //If chatterbox is not waiting then we have options we neeed to select.
			else if (chatterbox_get_option_count(Text_Chatterbox))
			{			
				#region //If scribble is on the last page then start up options.
				if (Dialog_Element.on_last_page() == true)
				{
					#region //Setting up the Dialog Choices.
					if (Dialog_ChoiceCreate == false)
					{
						var _option_count = chatterbox_get_option_count(Text_Chatterbox);
					
						for (var i = 0; i < _option_count; i++)
						{
							var _delay = "[delay," + string(500 * i) + "]";
							var _choice = chatterbox_get_option(Text_Chatterbox, i);
							var _string = _delay + _choice + "[delay,300]";
							Dialog_ChoiceElement[i] = scribble(_string);
							
							Dialog_ChoiceElement[i].typewriter_in(Text_Speed, 0); //Type writer effect.
							Dialog_ChoiceElement[i].typewriter_sound_per_char(Text_Voice, 1, 1); //Text sound.
						}
					
						Dialog_ChoiceCreate = true;
					}
					#endregion
					#region //Chatterbox Options Behavior.
					else if (Dialog_ChoiceCreate == true)
					{
						#region //Selector Behavior.
						if (Dialog_ChoiceSelector_Usable == true)
						{
							#region //Moving the Selector.
							#region //Up
							if (input_check_press(Controls.UP))
							{
								if (Dialog_ChoiceSelector == 0 or Dialog_ChoiceSelector == 1)
								{
									if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector + 2))
									{
										Dialog_ChoiceSelector += 2;
									}
								}
								else
								{
									if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector - 2))
									{
										Dialog_ChoiceSelector -= 2;
									}
								}
							}
							#endregion
							#region //Down
							else if (input_check_press(Controls.DOWN))
							{
								if (Dialog_ChoiceSelector == 2 or Dialog_ChoiceSelector == 3)
								{
									if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector - 2))
									{
										Dialog_ChoiceSelector -= 2;
									}
								}
								else
								{
									if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector + 2))
									{
										Dialog_ChoiceSelector += 2;
									}
								}
							}
							#endregion
							#region //Left
							else if (input_check_press(Controls.LEFT))
							{
								if (Dialog_ChoiceSelector == 0 or Dialog_ChoiceSelector == 2)
								{
									if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector + 1))
									{
										Dialog_ChoiceSelector += 1;
									}
								}
								else
								{
					
									Dialog_ChoiceSelector -= 1;
								}
							}
							#endregion
							#region //Right
							else if (input_check_press(Controls.RIGHT))
							{
								if (Dialog_ChoiceSelector == 1 or Dialog_ChoiceSelector == 3)
								{
									Dialog_ChoiceSelector -= 1;
								}
								else
								{
									if (chatterbox_get_option_count(Text_Chatterbox) > (Dialog_ChoiceSelector + 1))
									{
										Dialog_ChoiceSelector += 1;
									}
								}
							}
							#endregion
							#endregion
							#region //Selecting a choice.
							else if (input_check_press(Controls.ACTION))
							{
								chatterbox_select(Text_Chatterbox, Dialog_ChoiceSelector);
				
								#region //Load Chatterbox Dialog into scribble's cache.
								for (var i = 0; i < chatterbox_get_content_count(Text_Chatterbox); i++)
								{
									var _text_string = chatterbox_get_content(Text_Chatterbox, i);
									Dialog_Element = scribble(_text_string); //Put the dialog in cache.
									Dialog_Element.starting_format(Text_Font, Text_Color);
			
									#region //If the Dialog dosen't have a portrait sprite.
									if (Portrait_Sprite == -1)
									{
										Dialog_Element.wrap(550, 96); //Make sure that the text dosen't go past the textbox.
									}
									#endregion
									#region //If the Dialog does have a portrait sprite.
									else if (Portrait_Sprite != -1)
									{
										Dialog_Element.wrap(436, 96);
									}
									#endregion
								}
								#endregion
								#region //Initalize Scribble's Typewriter and continue in the Dialog.
								Dialog_Element.typewriter_in(Text_Speed, 0); //Initalize Typewriter effect.
								Dialog_Element.typewriter_sound_per_char(Text_Voice, 1, 1); //Initalize the Typewriter SFX.	
								Dialog_Talking = false; //Used for animating portraits and overworld characters.
								Dialog_Canskip = true; //Determines if the text can be skipped by player input.
								Dialog_Next = false; //If true then the dialog will advance on its own.					
								#endregion
								#region //Reset the Dialog Choice Variables for next time we come up to another set of choices.
								Dialog_ChoiceElement = []; 
								Dialog_ChoiceCreate = false; 
								Dialog_ChoiceSelector_Usable = false;
								Dialog_ChoiceSelector = 0;
								#endregion
							}
							#endregion
						}
						#endregion
						#region //Skipping the text fade in for the options if you didn't do it in time before. 
						else if (Dialog_ChoiceSelector_Usable == false)
						{
							if (input_check_press(Controls.CANCEL) and Dialog_Canskip == true)
							{
								var _option_count = chatterbox_get_option_count(Text_Chatterbox);
					
								for (var i = 0; i < _option_count; i ++)
								{
									Dialog_ChoiceElement[i].typewriter_skip();
								}
							}
						}
						#endregion
					}
					#endregion
				}
				#endregion
			}
			#endregion
		}
		#endregion
		#region //Scribble is currently fading in the text.
		else if (_done < 1)
		{
			#region //Skip the Text (And chatterbox options if there is any).
			if (input_check_press(Controls.CANCEL) and Dialog_Canskip == true)
			{				
				#region //Skip the text fade in for chatterbox options if there is any.
				if (chatterbox_get_option_count(Text_Chatterbox))
				{
					Dialog_Element.typewriter_skip();
					var _option_count = chatterbox_get_option_count(Text_Chatterbox);
					
					for (var i = 0; i < _option_count; i ++)
					{
						var _choice = chatterbox_get_option(Text_Chatterbox, i);
						Dialog_ChoiceElement[i] = scribble(_choice);
						Dialog_ChoiceCreate = true;
					}
					
					Dialog_Talking = false;
				}
				#endregion
				#region //Skip text like normal if there are no options to select.
				else if (!chatterbox_get_option_count(Text_Chatterbox))
				{
					Dialog_Element.typewriter_skip();
					Dialog_Talking = false;
				}
				#endregion
			}
			#endregion
		}
		#endregion
	}
	#endregion
	#region //Instant-Fade Dialog
	else if (Text_Method == 2) 
	{
		
	}
	#endregion
	#endregion
}