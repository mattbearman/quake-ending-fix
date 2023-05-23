void() standin_axe_swing;
void() standin_axe_blood;
void() standin_axe_sound;

float AX_DIR_UP = 0;
float AX_DIR_DOWN = 1;
float AX_DIR_LEFT = 2;
float AX_DIR_RIGHT = 3;
float AX_SWING_X = 60;
float AX_SWING_Z = 50;

void() standin_attack =
{
  standin_axe_swing();

  self.think = standin_attack;
  self.nextthink = time + (0.8 - ((self.cnt + random() - 0.5) * 0.035));
	self.cnt += 1;
}

// draw a line of blood splatters over shub
void() standin_axe_swing =
{
	local vector line_start, line_end;
	local float i, ax_dir, ax_step_x, ax_step_z;
	local entity ax_swing;

	// set start and end points
	// standin           == shub - '32 264 0';
  // blood bottom left == shub - '45 200 10'
  // diff              ==      - '13 -64 10'
	line_start = self.origin - '13 -64 10';
	line_end = line_start;

	// choose a direction
	ax_dir = rint(random() * 3);

	if (ax_dir == AX_DIR_UP) {
		line_start_x += random() * AX_SWING_X;
		line_end_x += random() * AX_SWING_X;
		line_end_z += AX_SWING_Z;
	}
	else if (ax_dir == AX_DIR_DOWN) {
		line_start_x += random() * AX_SWING_X;
		line_start_z += AX_SWING_Z;
		line_end_x += random() * AX_SWING_X;
	}
	else if (ax_dir == AX_DIR_LEFT) {
		line_start_x += AX_SWING_X;
		line_start_z +=  random() * AX_SWING_Z;
		line_end_z +=  random() * AX_SWING_Z;
	}
	else if (ax_dir == AX_DIR_RIGHT) {
		line_start_z +=  random() * AX_SWING_Z;
		line_end_x += AX_SWING_X;
		line_end_z +=  random() * AX_SWING_Z;
	}
	else {
		error("invalid ax_dir");
	}

	// interpolate points from line start to end
	ax_step_x = (line_end_x - line_start_x) / 10;
	ax_step_z = (line_end_z - line_start_z) / 10;

	for (i = 0; i <= 10; i++) {
		ax_swing = spawn();
		ax_swing.origin = line_start;
		ax_swing.origin_x += i * ax_step_x;
		ax_swing.origin_z += i * ax_step_z;

    ax_swing.health = - (self.cnt * 4);
    ax_swing.think = standin_axe_blood;

		ax_swing.nextthink = time + i * 0.01;
	}

  standin_axe_sound();
}

void() standin_axe_blood =
{
  local float r;

	SpawnBlood(self.origin, '0 0 0', 50);

  // randomly spawn a gib
  r = random();

  if (r <= 0.02)
    ThrowGib ("progs/gib1.mdl", self.health);
  else if (r <= 0.03)
    ThrowGib ("progs/gib2.mdl", self.health);

	remove(self);
}

void() standin_axe_sound =
{
  local float r;

	// play a random axe swing sound
	r = rint((random() * 3));

	if (r == 0)
		sound (self, CHAN_AUTO, "knight/sword2.wav", 1, ATTN_NORM);
	else if (r == 1)
		sound (self, CHAN_AUTO, "zombie/z_shot1.wav", 1, ATTN_NORM);
	else
		sound (self, CHAN_AUTO, "knight/sword1.wav", 1, ATTN_NORM);


	// play a random fleshy hit sound
	r = rint((random() * 3));

	if (r == 0)
		sound (self, CHAN_AUTO, "shambler/smack.wav", 0.6, ATTN_NORM);
	else if (r == 1)
		sound (self, CHAN_AUTO, "zombie/z_miss.wav", 0.6, ATTN_NORM);
	else
		sound (self, CHAN_AUTO, "player/tornoff2.wav", 0.6, ATTN_NORM);
		sound (self, CHAN_AUTO, "blob/hit1.wav", 0.6, ATTN_NORM);
}

void() standin_show =
{
  standin_axe_swing();

	setmodel(self, "progs/player.mdl");

	self.weapon = IT_AXE;
	self.nextthink = time;
	self.think = player_axe3;

	// play player gasp sound
	sound(self, CHAN_AUTO, "player/gasp1.wav", 1, ATTN_NORM);
}

entity(vector pos, vector dir) entity_standin =
{
  local entity standin;

  standin = spawn();
	setorigin(standin, pos);
	standin.angles = dir;

  return standin;
}
