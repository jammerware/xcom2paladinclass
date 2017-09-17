class X2Item_HolyBlade extends X2Item config(GameData_WeaponData);

var config WeaponDamageValue HOLYBLADE_CONVENTIONAL_BASEDAMAGE;
//var config WeaponDamageValue HOLYBLADE_MAGNETIC_BASEDAMAGE;
//var config WeaponDamageValue HOLYBLADE_BEAM_BASEDAMAGE;

var config int HOLYBLADE_CONVENTIONAL_AIM;
var config int HOLYBLADE_CONVENTIONAL_CRITCHANCE;
var config int HOLYBLADE_CONVENTIONAL_ICLIPSIZE;
var config int HOLYBLADE_CONVENTIONAL_ISOUNDRANGE;
var config int HOLYBLADE_CONVENTIONAL_IENVIRONMENTDAMAGE;

//var config int HOLYBLADE_MAGNETIC_AIM;
//var config int HOLYBLADE_MAGNETIC_CRITCHANCE;
//var config int HOLYBLADE_MAGNETIC_ICLIPSIZE;
//var config int HOLYBLADE_MAGNETIC_ISOUNDRANGE;
//var config int HOLYBLADE_MAGNETIC_IENVIRONMENTDAMAGE;
//var config int HOLYBLADE_MAGNETIC_STUNCHANCE;

//var config int HOLYBLADE_BEAM_AIM;
//var config int HOLYBLADE_BEAM_CRITCHANCE;
//var config int HOLYBLADE_BEAM_ICLIPSIZE;
//var config int HOLYBLADE_BEAM_ISOUNDRANGE;
//var config int HOLYBLADE_BEAM_IENVIRONMENTDAMAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;
	
	Weapons.AddItem(CreateTemplate_HolyBlade_Conventional());

	return Weapons;
}

static function X2DataTemplate CreateTemplate_HolyBlade_Conventional()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'HolyBlade');
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'holyblade';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.Sword";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.StowedLocation = eSlot_RightBack;

	// This all the resources; sounds, animations, models, physics, the works.
	// TODO: custom sweet resources?
	Template.GameArchetype = "WP_Sword_CV.WP_Sword_CV";
	Template.AddDefaultAttachment('Sheath', "ConvSword.Meshes.SM_ConvSword_Sheath", true);
	Template.Tier = 0;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = default.HOLYBLADE_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = default.HOLYBLADE_CONVENTIONAL_AIM;
	Template.CritChance = default.HOLYBLADE_CONVENTIONAL_CRITCHANCE;
	Template.iSoundRange = default.HOLYBLADE_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.HOLYBLADE_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';
	Template.DamageTypeTemplateName = 'Melee';

	`LOG("PaladinClass: Base damage: " @ string(default.HOLYBLADE_CONVENTIONAL_BASEDAMAGE.Damage) @ ".");
	`LOG("PaladinClass: Aim: " @ string(default.HOLYBLADE_CONVENTIONAL_AIM) @ ".");
	
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	`LOG("PaladinClass: Holy Blade template created.");

	return Template;
}