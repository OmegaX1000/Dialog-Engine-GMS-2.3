/// @description Insert description here
// You can write your code in this editor

//Initalize Dialog File
Chatterbox_File = ""; //The file that contains all of the dialog needed.
Chatterbox_StartNode = ""; //This is where the dialog will start.
Text_Chatterbox = -1; //Creates a chatterbox. This will hold the dialog file.

//Initalize Text Variables (Initalized in Script use.)
Text_Position = false; //Where the text box is draw (top = true, bottom = false).
Text_Method = 0; //How the text will appear. (Instant, Typed, Instant-Fade.)
Text_Font = ""; //What font the text will use.
Text_Color = 0; //What color the text will be when it starts.
Text_Voice = 0; //The text sound that plays if the text is being typed out.
Text_Speed = 0; //How fast will the text be typed out. (Typed Method only.)
Dialog_Element = SCRIBBLE_NULL_ELEMENT; //The dialog that will be drawn.

//Initalize Portrait Variables (Initalized in Script use.)
Portrait_Sprite = -1; //The sprite index that the will be displayed (if there is one.)
Portrait_Character = 0; //The character who is talking. This will control who is animating when talking (portrait sprite and overworld sprite).
Portrait_Index = 0; //What the current image index of the portrait sprite. (Basically an animating portrait)

//Initalize Choice Variables
Dialog_ChoiceElement = []; //The choices that will be drawn.
Dialog_ChoiceCreate = false; //Initalizes the Dialog Choices, if any.
Dialog_ChoiceSelector_Usable = false; //If turned on allows the player to move and select choices.
Dialog_ChoiceSelector = 0; //Selector for when your presented options.

//Initalize rest of the variables.
Dialog_StartNode_Init = false; //Used to send the chatterbox to the starting node during the first time.
Dialog_Talking = false; //Used for animating portraits and overworld characters.
Dialog_Canskip = true; //Determines if the text can be skipped by player input.
Dialog_Next = false; //If true then the dialog will advance on its own.
Dialog_Create = false; //Initalizes Dialog.