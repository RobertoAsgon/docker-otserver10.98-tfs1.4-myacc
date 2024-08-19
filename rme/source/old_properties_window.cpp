//////////////////////////////////////////////////////////////////////
// This file is part of Remere's Map Editor
//////////////////////////////////////////////////////////////////////

#include "main.h"

#include <wx/grid.h>

#include "tile.h"
#include "item.h"
#include "complexitem.h"
#include "town.h"
#include "house.h"
#include "map.h"
#include "editor.h"

#include "gui.h"
#include "application.h"
#include "old_properties_window.h"
#include "container_properties_window.h"

// ============================================================================
// Old Properties Window

BEGIN_EVENT_TABLE(OldPropertiesWindow, wxDialog)
	EVT_SET_FOCUS(OldPropertiesWindow::OnFocusChange)
	EVT_BUTTON(wxID_OK, OldPropertiesWindow::OnClickOK)
	EVT_BUTTON(wxID_CANCEL, OldPropertiesWindow::OnClickCancel)
END_EVENT_TABLE()

OldPropertiesWindow::OldPropertiesWindow(wxWindow* win_parent, const Map* map, const Tile* tile_parent, Item* item, wxPoint pos) :
	ObjectPropertiesWindowBase(win_parent, wxT("Item Properties"), map, tile_parent, item, pos),
	count_field(nullptr),
	action_id_field(nullptr),
	unique_id_field(nullptr),
	door_id_field(nullptr),
	depot_id_field(nullptr),
	splash_type_field(nullptr),
	text_field(nullptr),
	description_field(nullptr)
{
	ASSERT(edit_item);
	
	wxSizer* topsizer = newd wxBoxSizer(wxVERTICAL);
	if(Container* container = dynamic_cast<Container*>(edit_item)) {
		// Container
		wxSizer* boxsizer = newd wxStaticBoxSizer(wxVERTICAL, this, wxT("Container Properties"));

		wxFlexGridSizer* subsizer = newd wxFlexGridSizer(2, 10, 10);
		subsizer->AddGrowableCol(1);
		
		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("ID ") + i2ws(item->getID())));
		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("\"") + wxstr(item->getName()) + wxT("\"")));

		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Action ID")));
		action_id_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(edit_item->getActionID()), wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 0, 0xFFFF, edit_item->getActionID());
		subsizer->Add(action_id_field, wxSizerFlags(1).Expand());

		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Unique ID")));
		unique_id_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(edit_item->getUniqueID()), wxDefaultPosition, wxSize(-1, 20), wxSP_ARROW_KEYS, 0, 0xFFFF, edit_item->getUniqueID());
		subsizer->Add(unique_id_field, wxSizerFlags(1).Expand());
		
		boxsizer->Add(subsizer, wxSizerFlags(0).Expand());

		// Now we add the subitems!
		wxSizer* contents_sizer = newd wxStaticBoxSizer(wxVERTICAL, this, wxT("Contents"));

		bool use_large_sprites = settings.getBoolean(Config::USE_LARGE_CONTAINER_ICONS);
		wxSizer* horizontal_sizer = nullptr;
		const int additional_height_increment = (use_large_sprites? 40 : 24);
		int additional_height = 0;

		int32_t maxColumns;
		if (use_large_sprites) {
			maxColumns = 6;
		} else {
			maxColumns = 12;
		}

		for (int32_t index = 0; index < container->getVolume(); ++index) {
			if (!horizontal_sizer) {
				horizontal_sizer = newd wxBoxSizer(wxHORIZONTAL);
			}

			Item* item = container->getItem(index);
			ContainerItemButton* containerItemButton = newd ContainerItemButton(this, use_large_sprites, index, map, item);

			container_items.push_back(containerItemButton);
			horizontal_sizer->Add(containerItemButton);

			if (((index + 1) % maxColumns) == 0) {
				contents_sizer->Add(horizontal_sizer);
				horizontal_sizer = nullptr;
				additional_height += additional_height_increment;
			}
		}

		if(horizontal_sizer != nullptr) {
			contents_sizer->Add(horizontal_sizer);
			additional_height += additional_height_increment;
		}

		boxsizer->Add(contents_sizer, wxSizerFlags(2).Expand());

		topsizer->Add(boxsizer, wxSizerFlags(0).Expand().Border(wxALL, 20));

		//SetSize(260, 150 + additional_height);
	} else if(edit_item->canHoldText() || edit_item->canHoldDescription()) {
		// Book
		wxSizer* boxsizer = newd wxStaticBoxSizer(wxVERTICAL, this, wxT("Writeable Properties"));

		wxFlexGridSizer* subsizer = newd wxFlexGridSizer(2, 10, 10);
		subsizer->AddGrowableCol(1);
		
		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("ID ") + i2ws(item->getID())));
		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("\"") + wxstr(item->getName()) + wxT("\"")));

		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Action ID")));
		action_id_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(edit_item->getActionID()), wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 0, 0xFFFF, edit_item->getActionID());
		action_id_field->SetSelection(-1, -1);
		subsizer->Add(action_id_field, wxSizerFlags(1).Expand());

		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Unique ID")));
		unique_id_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(edit_item->getUniqueID()), wxDefaultPosition, wxSize(-1, 20), wxSP_ARROW_KEYS, 0, 0xFFFF, edit_item->getUniqueID());
		subsizer->Add(unique_id_field, wxSizerFlags(1).Expand());
		
		boxsizer->Add(subsizer, wxSizerFlags(1).Expand());

		wxSizer* textsizer = newd wxBoxSizer(wxVERTICAL);
		textsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Text")), wxSizerFlags(1).Center());
		text_field = newd wxTextCtrl(this, wxID_ANY, wxstr(item->getText()), wxDefaultPosition, wxDefaultSize, wxTE_MULTILINE);
		textsizer->Add(text_field, wxSizerFlags(7).Expand());

		boxsizer->Add(textsizer, wxSizerFlags(2).Expand());

		topsizer->Add(boxsizer, wxSizerFlags(0).Expand().Border(wxALL, 20));

		//SetSize(220, 310);
	} else if(edit_item->isSplash() || edit_item->isFluidContainer()) {
		// Splash
		wxSizer* boxsizer = newd wxStaticBoxSizer(wxVERTICAL, this, wxT("Splash Properties"));

		wxFlexGridSizer* subsizer = newd wxFlexGridSizer(2, 10, 10);
		subsizer->AddGrowableCol(1);
		
		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("ID ") + i2ws(item->getID())));
		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("\"") + wxstr(item->getName()) + wxT("\"")));

		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Type")));

		// Splash types
		splash_type_field = newd wxChoice(this, wxID_ANY);
		if (edit_item->isFluidContainer()) {
			splash_type_field->Append(wxstr(Item::LiquidID2Name(LIQUID_NONE)), newd int32_t(LIQUID_NONE));
		}

		for (SplashType splashType = LIQUID_FIRST; splashType != LIQUID_LAST; ++splashType) {
			splash_type_field->Append(wxstr(Item::LiquidID2Name(splashType)), newd int32_t(splashType));
		}

		if (item->getSubtype()) {
			const std::string& what = Item::LiquidID2Name(item->getSubtype());
			if (what == "Unknown") {
				splash_type_field->Append(wxstr(Item::LiquidID2Name(LIQUID_NONE)), newd int32_t(LIQUID_NONE));
			}
			splash_type_field->SetStringSelection(wxstr(what));
		} else {
			splash_type_field->SetSelection(0);
		}

		subsizer->Add(splash_type_field, wxSizerFlags(1).Expand());

		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Action ID")));
		action_id_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(edit_item->getActionID()), wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 0, 0xFFFF, edit_item->getActionID());
		subsizer->Add(action_id_field, wxSizerFlags(1).Expand());

		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Unique ID")));
		unique_id_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(edit_item->getUniqueID()), wxDefaultPosition, wxSize(-1, 20), wxSP_ARROW_KEYS, 0, 0xFFFF, edit_item->getUniqueID());
		subsizer->Add(unique_id_field, wxSizerFlags(1).Expand());

		boxsizer->Add(subsizer, wxSizerFlags(1).Expand());

		topsizer->Add(boxsizer, wxSizerFlags(0).Expand().Border(wxALL, 20));

		//SetSize(220, 190);
	} else if(Depot* depot = dynamic_cast<Depot*>(edit_item)) {
		// Depot
		wxSizer* boxsizer = newd wxStaticBoxSizer(wxVERTICAL, this, wxT("Depot Properties"));
		wxFlexGridSizer* subsizer = newd wxFlexGridSizer(2, 10, 10);
		
		subsizer->AddGrowableCol(1);
		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("ID ") + i2ws(item->getID())));
		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("\"") + wxstr(item->getName()) + wxT("\"")));
		
		const Towns& towns = map->towns;
		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Depot ID")));
		depot_id_field = newd wxChoice(this, wxID_ANY);
		int to_select_index = 0;
		if(towns.count() > 0) {
			bool found = false;
			for(TownMap::const_iterator town_iter = towns.begin();
					town_iter != towns.end();
					++town_iter)
			{
				if(town_iter->second->getID() == depot->getDepotID()) {
					found = true;
				}
				depot_id_field->Append(wxstr(town_iter->second->getName()), newd int(town_iter->second->getID()));
				if(found == false) ++to_select_index;
			}
			if(found == false) {
				if(depot->getDepotID() != 0) {
					depot_id_field->Append(wxT("Undefined Town (id:") + i2ws(depot->getDepotID()) + wxT(")"), newd int(depot->getDepotID()));
				}
			}
		}
		depot_id_field->Append(wxT("No Town"), newd int(0));
		if(depot->getDepotID() == 0) {
			to_select_index = depot_id_field->GetCount() - 1;
		}
		depot_id_field->SetSelection(to_select_index);

		subsizer->Add(depot_id_field, wxSizerFlags(1).Expand());

		boxsizer->Add(subsizer, wxSizerFlags(5).Expand());
		topsizer->Add(boxsizer, wxSizerFlags(0).Expand().Border(wxALL, 20));
		//SetSize(220, 140);
	} else {
		// Normal item
		Door* door = dynamic_cast<Door*>(edit_item);
		Teleport* teleport = dynamic_cast<Teleport*>(edit_item);
		
		wxString description;
		if(door) {
			ASSERT(tile_parent);
			description = wxT("Door Properties");
		} else if(teleport) {
			description = wxT("Teleport Properties");
		} else {
			description = wxT("Item Properties");
		}

		wxSizer* boxsizer = newd wxStaticBoxSizer(wxVERTICAL, this, description);

		int num_items = 4;
		//if(item->canHoldDescription()) num_items += 1;
		if(door) num_items += 1;
		if(teleport) num_items += 1;

		wxFlexGridSizer* subsizer = newd wxFlexGridSizer(2, 10, 10);
		subsizer->AddGrowableCol(1);
		
		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("ID ") + i2ws(item->getID())));
		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("\"") + wxstr(item->getName()) + wxT("\"")));

		subsizer->Add(newd wxStaticText(this, wxID_ANY, (item->isCharged()? wxT("Charges") : wxT("Count"))));
		int max_count = 100;
		if(item->isClientCharged()) max_count = 250;
		if(item->isExtraCharged()) max_count = 65500;
		count_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(edit_item->getCount()), wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 1, max_count, edit_item->getCount());
		if(item->isStackable() == false && item->isCharged() == false) {
			count_field->Enable(false);
		}
		subsizer->Add(count_field, wxSizerFlags(1).Expand());

		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Action ID")));
		action_id_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(edit_item->getActionID()), wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 0, 0xFFFF, edit_item->getActionID());
		subsizer->Add(action_id_field, wxSizerFlags(1).Expand());

		subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Unique ID")));
		unique_id_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(edit_item->getUniqueID()), wxDefaultPosition, wxSize(-1, 20), wxSP_ARROW_KEYS, 0, 0xFFFF, edit_item->getUniqueID());
		subsizer->Add(unique_id_field, wxSizerFlags(1).Expand());
		
		/*
		if(item->canHoldDescription()) {
			subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Description")));
			description_field = newd wxTextCtrl(this, wxID_ANY, edit_item->getText(), wxDefaultPosition, wxSize(-1, 20));
			subsizer->Add(description_field, wxSizerFlags(1).Expand());
		}
		*/

		if(door) {
			subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Door ID")));
			door_id_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(door->getDoorID()), wxDefaultPosition, wxSize(-1, 20), wxSP_ARROW_KEYS, 0, 0xFF, door->getDoorID());
			if(!edit_tile || edit_tile->isHouseTile() == false) {
				door_id_field->Disable();
			}
			subsizer->Add(door_id_field, wxSizerFlags(1).Expand());
		}

		if(teleport) {
			subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Destination")));

			wxSizer* possizer = newd wxBoxSizer(wxHORIZONTAL);
			x_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(teleport->getX()), wxDefaultPosition, wxSize(-1, 20), wxSP_ARROW_KEYS, 0, map->getWidth(), teleport->getX());
			possizer->Add(x_field, wxSizerFlags(3).Expand());
			y_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(teleport->getY()), wxDefaultPosition, wxSize(-1, 20), wxSP_ARROW_KEYS, 0, map->getHeight(), teleport->getY());
			possizer->Add(y_field, wxSizerFlags(3).Expand());
			z_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(teleport->getZ()), wxDefaultPosition, wxSize(-1, 20), wxSP_ARROW_KEYS, 0, 15, teleport->getZ());
			possizer->Add(z_field, wxSizerFlags(2).Expand());

			subsizer->Add(possizer, wxSizerFlags(1).Expand());
		}

		boxsizer->Add(subsizer, wxSizerFlags(1).Expand());

		topsizer->Add(boxsizer, wxSizerFlags(0).Expand().Border(wxALL, 20));
		//SetSize((teleport? 260 : 220), 30 + num_items*40);
	}

	// topsizer->Add(createAttributeList(this), wxSizerFlags(1).Expand().Border(wxALL, 20));

	wxSizer* subsizer = newd wxBoxSizer(wxHORIZONTAL);
	subsizer->Add(newd wxButton(this, wxID_OK, wxT("OK")), wxSizerFlags(1).Center());
	subsizer->Add(newd wxButton(this, wxID_CANCEL, wxT("Cancel")), wxSizerFlags(1).Center());
	topsizer->Add(subsizer, wxSizerFlags(0).Center().Border(wxLEFT | wxRIGHT | wxBOTTOM, 20));

	SetSizerAndFit(topsizer);
}

OldPropertiesWindow::OldPropertiesWindow(wxWindow* win_parent, const Map* map, const Tile* tile_parent, Creature* creature, wxPoint pos) :
	ObjectPropertiesWindowBase(win_parent, wxT("Creature Properties"), map, tile_parent, creature, pos),
	count_field(nullptr),
	action_id_field(nullptr),
	unique_id_field(nullptr),
	door_id_field(nullptr),
	depot_id_field(nullptr),
	splash_type_field(nullptr),
	text_field(nullptr),
	description_field(nullptr)
{
	ASSERT(edit_creature);
	
	wxSizer* topsizer = newd wxBoxSizer(wxVERTICAL);
	wxSizer* boxsizer = newd wxStaticBoxSizer(wxVERTICAL, this, wxT("Creature Properties"));

	wxFlexGridSizer* subsizer = newd wxFlexGridSizer(2, 10, 10);
	subsizer->AddGrowableCol(1);
	
	subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Creature ")));
	subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("\"") + wxstr(edit_creature->getName()) + wxT("\"")), wxSizerFlags(1).Expand());

	subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Spawn interval")));
	count_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(edit_creature->getSpawnTime()), wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 10, 3600, edit_creature->getSpawnTime());
	// count_field->SetSelection(-1, -1);
	subsizer->Add(count_field, wxSizerFlags(1).Expand());

	boxsizer->Add(subsizer, wxSizerFlags(1).Expand());

	topsizer->Add(boxsizer, wxSizerFlags(3).Expand().Border(wxALL, 20));
	SetSize(220, 0);

	wxSizer* std_sizer = newd wxBoxSizer(wxHORIZONTAL);
	std_sizer->Add(newd wxButton(this, wxID_OK, wxT("OK")), wxSizerFlags(1).Center());
	std_sizer->Add(newd wxButton(this, wxID_CANCEL, wxT("Cancel")), wxSizerFlags(1).Center());
	topsizer->Add(std_sizer, wxSizerFlags(0).Center().Border(wxLEFT | wxRIGHT | wxBOTTOM, 20));

	SetSizerAndFit(topsizer);
}

OldPropertiesWindow::OldPropertiesWindow(wxWindow* win_parent, const Map* map, const Tile* tile_parent, Spawn* spawn, wxPoint pos) :
	ObjectPropertiesWindowBase(win_parent, wxT("Spawn Properties"), map, tile_parent, spawn, pos),
	count_field(nullptr),
	action_id_field(nullptr),
	unique_id_field(nullptr),
	door_id_field(nullptr),
	depot_id_field(nullptr),
	splash_type_field(nullptr),
	text_field(nullptr),
	description_field(nullptr)
{
	ASSERT(edit_spawn);
	
	wxSizer* topsizer = newd wxBoxSizer(wxVERTICAL);
	wxSizer* boxsizer = newd wxStaticBoxSizer(wxVERTICAL, this, wxT("Spawn Properties"));

	//if(item->canHoldDescription()) num_items += 1;

	wxFlexGridSizer* subsizer = newd wxFlexGridSizer(2, 10, 10);
	subsizer->AddGrowableCol(1);

	subsizer->Add(newd wxStaticText(this, wxID_ANY, wxT("Spawn size")));
	count_field = newd wxSpinCtrl(this, wxID_ANY, i2ws(edit_spawn->getSize()), wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 1, settings.getInteger(Config::MAX_SPAWN_RADIUS), edit_spawn->getSize());
	// count_field->SetSelection(-1, -1);
	subsizer->Add(count_field, wxSizerFlags(1).Expand());

	boxsizer->Add(subsizer, wxSizerFlags(1).Expand());

	topsizer->Add(boxsizer, wxSizerFlags(3).Expand().Border(wxALL, 20));

	wxSizer* std_sizer = newd wxBoxSizer(wxHORIZONTAL);
	std_sizer->Add(newd wxButton(this, wxID_OK, wxT("OK")), wxSizerFlags(1).Center());
	std_sizer->Add(newd wxButton(this, wxID_CANCEL, wxT("Cancel")), wxSizerFlags(1).Center());
	topsizer->Add(std_sizer, wxSizerFlags(0).Center().Border(wxLEFT | wxRIGHT | wxBOTTOM, 20));
	
	SetSizerAndFit(topsizer);
}

OldPropertiesWindow::~OldPropertiesWindow()
{
	// Warning: edit_item may no longer be valid, DONT USE IT!
	if(splash_type_field)
	{
		for(uint32_t i = 0; i < splash_type_field->GetCount(); ++i)
		{
			delete reinterpret_cast<int*>(splash_type_field->GetClientData(i));
		}
	}
	if(depot_id_field)
	{
		for(uint32_t i = 0; i < depot_id_field->GetCount(); ++i)
		{
			delete reinterpret_cast<int*>(depot_id_field->GetClientData(i));
		}
	}
}

void OldPropertiesWindow::OnFocusChange(wxFocusEvent& event)
{
	wxWindow* win = event.GetWindow();
	if (wxSpinCtrl* spin = dynamic_cast<wxSpinCtrl*>(win))
		spin->SetSelection(-1, -1);
	else if (wxTextCtrl* text = dynamic_cast<wxTextCtrl*>(win))
		text->SetSelection(-1, -1);
}

void OldPropertiesWindow::OnClickOK(wxCommandEvent& WXUNUSED(event))
{
	if(edit_item) {
		if(dynamic_cast<Container*>(edit_item)) {
			// Container
			int new_uid = unique_id_field->GetValue();
			int new_aid = action_id_field->GetValue();
			
			if((new_uid < 1000 || new_uid > 0xFFFF) && new_uid != 0) {
				gui.PopupDialog(this, wxT("Error"), wxT("Unique ID must be between 1000 and 65535."), wxOK);
				return;
			}
			if(/* there is no item with the same UID */false) {
				gui.PopupDialog(this, wxT("Error"), wxT("Unique ID must be unique, this UID is already taken."), wxOK);
				return;
			}
			if((new_aid < 100 || new_aid > 0xFFFF) && new_aid != 0) {
				gui.PopupDialog(this, wxT("Error"), wxT("Action ID must be between 100 and 65535."), wxOK);
				return;
			}

			edit_item->setUniqueID(new_uid);
			edit_item->setActionID(new_aid);
		} else if(edit_item->canHoldText() || edit_item->canHoldDescription()) {
			// Book
			int new_uid = unique_id_field->GetValue();
			int new_aid = action_id_field->GetValue();
			std::string text = nstr(text_field->GetValue());

			if((new_uid < 1000 || new_uid > 0xFFFF) && new_uid != 0) {
				gui.PopupDialog(this, wxT("Error"), wxT("Unique ID must be between 1000 and 65535."), wxOK);
				return;
			}
			if(/* there is no item with the same UID */false) {
				gui.PopupDialog(this, wxT("Error"), wxT("Unique ID must be unique, this UID is already taken."), wxOK);
				return;
			}
			if((new_aid < 100 || new_aid > 0xFFFF) && new_aid != 0) {
				gui.PopupDialog(this, wxT("Error"), wxT("Action ID must be between 100 and 65535."), wxOK);
				return;
			}
			if(text.length() >= 0xFFFF) {
				gui.PopupDialog(this, wxT("Error"), wxT("Text is longer than 65535 characters, this is not supported by OpenTibia. Reduce the length of the text."), wxOK);
				return;
			}
			if(edit_item->canHoldText() && text.length() > edit_item->getMaxWriteLength()) {
				int ret = gui.PopupDialog(this, wxT("Error"), wxT("Text is longer than the maximum supported length of this book type, do you still want to change it?"), wxYES | wxNO);
				if(ret != wxID_YES) {
					return;
				}
			}

			edit_item->setUniqueID(new_uid);
			edit_item->setActionID(new_aid);
			edit_item->setText(text);
		} else if(edit_item->isSplash() || edit_item->isFluidContainer()) {
			// Splash
			int new_uid = unique_id_field->GetValue();
			int new_aid = action_id_field->GetValue();
			int* new_type = reinterpret_cast<int*>(splash_type_field->GetClientData(splash_type_field->GetSelection()));

			if((new_uid < 1000 || new_uid > 0xFFFF) && new_uid != 0) {
				gui.PopupDialog(this, wxT("Error"), wxT("Unique ID must be between 1000 and 65535."), wxOK);
				return;
			}
			if(/* there is no item with the same UID */false) {
				gui.PopupDialog(this, wxT("Error"), wxT("Unique ID must be unique, this UID is already taken."), wxOK);
				return;
			}
			if((new_aid < 100 || new_aid > 0xFFFF) && new_aid != 0) {
				gui.PopupDialog(this, wxT("Error"), wxT("Action ID must be between 100 and 65535."), wxOK);
				return;
			}
			if(new_type) {
				edit_item->setSubtype(*new_type);
			}
			edit_item->setUniqueID(new_uid);
			edit_item->setActionID(new_aid);

			// Clean up client data
		} else if(Depot* depot = dynamic_cast<Depot*>(edit_item)) {
			// Depot
			int* new_depotid = reinterpret_cast<int*>(depot_id_field->GetClientData(depot_id_field->GetSelection()));

			depot->setDepotID(*new_depotid);
		} else {
			// Normal item
			Door* door = dynamic_cast<Door*>(edit_item);
			Teleport* teleport = dynamic_cast<Teleport*>(edit_item);

			int new_uid = unique_id_field->GetValue();
			int new_aid = action_id_field->GetValue();
			int new_count = count_field? count_field->GetValue() : 1;
			std::string new_desc;
			if(edit_item->canHoldDescription() && description_field) {
				description_field->GetValue();
			}
			Position new_dest;
			if(teleport) {
				new_dest = Position(x_field->GetValue(), y_field->GetValue(), z_field->GetValue());
			}
			uint8_t new_door_id = 0;
			if(door) {
				new_door_id = door_id_field->GetValue();
			}
			
			if((new_uid < 1000 || new_uid > 0xFFFF) && new_uid != 0) {
				gui.PopupDialog(this, wxT("Error"), wxT("Unique ID must be between 1000 and 65535."), wxOK);
				return;
			}
			if(/* there is no item with the same UID */false) {
				gui.PopupDialog(this, wxT("Error"), wxT("Unique ID must be unique, this UID is already taken."), wxOK);
				return;
			}
			if((new_aid < 100 || new_aid > 0xFFFF) && new_aid != 0) {
				gui.PopupDialog(this, wxT("Error"), wxT("Action ID must be between 100 and 65535."), wxOK);
				return;
			}

			/*
			if(edit_item->canHoldDescription()) {
				if(new_desc.length() > 127) {
					gui.PopupDialog("Error", "Description must be shorter than 127 characters.", wxOK);
					return;
				}
			}
			*/

			if(door && settings.getInteger(Config::WARN_FOR_DUPLICATE_ID)) {
				if(edit_tile && edit_tile->isHouseTile()) {
					const House* house = edit_map->houses.getHouse(edit_tile->getHouseID());
					if(house) {
						Position pos = house->getDoorPositionByID(new_door_id);
						if(pos == Position()) {
							// Do nothing
						} else if(pos != edit_tile->getPosition()) {
							int ret = gui.PopupDialog(this, wxT("Warning"), wxT("This doorid conflicts with another one in this house, are you sure you want to continue?"), wxYES | wxNO);
							if(ret == wxID_NO) {
								return;
							}
						}
					}
				}
			}

			if(teleport) {
				if(edit_map->getTile(new_dest) == nullptr || edit_map->getTile(new_dest)->isBlocking()) {
					int ret = gui.PopupDialog(this, wxT("Warning"), wxT("This teleport leads nowhere, or to an invalid location. Do you want to change the destination?"), wxYES | wxNO);
					if(ret == wxID_YES) {
						return;
					}
				}
			}
			
			// Done validating, set the values.
			if(edit_item->canHoldDescription()) {
				edit_item->setText(new_desc);
			}
			if(edit_item->isStackable() || edit_item->isCharged()) {
				edit_item->setSubtype(new_count);
			}
			if(door) {
				door->setDoorID(new_door_id);
			}
			if(teleport) {
				teleport->setDestination(new_dest);
			}

			edit_item->setUniqueID(new_uid);
			edit_item->setActionID(new_aid);
		}
	} else if(edit_creature) {
		int new_spawntime = count_field->GetValue();
		edit_creature->setSpawnTime(new_spawntime);
	} else if(edit_spawn) {
		int new_spawnsize = count_field->GetValue();
		edit_spawn->setSize(new_spawnsize);
	}
	EndModal(1);
}

void OldPropertiesWindow::OnClickCancel(wxCommandEvent& WXUNUSED(event))
{
	// Just close this window
	EndModal(0);
}

void OldPropertiesWindow::Update()
{
	Container* container = dynamic_cast<Container*>(edit_item);
	if (container) {
		for (int32_t i = 0; i < container->getVolume(); ++i) {
			container_items[i]->setItem(container->getItem(i));
		}
	}
	wxDialog::Update();
}
