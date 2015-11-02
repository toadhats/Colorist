// This should probably be a full-fledged library, I need to work out how to do that.
void setup() {
  size(600, 600);
  Colorist c = new Colorist();

  color bg = c.getColor("burlywood");
  background(bg);
}

class Colorist {

  int opacity;
  Table palette;

  Colorist() {
    opacity = 255;
    loadColors("colors.csv");
  }

  Colorist(int o) {
    opacity = o; // That's 'o', not zero.
    palette = new Table();
  }

  Colorist(int o, String file) {
    opacity = o; // That's 'o', not zero.
    loadColors(file);
  }

  color hexColor(int hex) {
    int r = (hex & 0xFF0000) >> 16;
    int g = (hex & 0xFF00) >> 8;
    int b = (hex & 0xFF);
    return color(r, g, b);
  }

  /*** Converts a hex representation to a color.***/
  color toColor(String hexcolor) {
    hexcolor = hexcolor.trim();
    if (hexcolor.charAt(0) == '#') { // Catch and remove a hash
      hexcolor = hexcolor.substring(1);
    }
    if (hexcolor.length() == 3) { // The stupid shorthand case, double each digit
    print("Expanding " + hexcolor + "->");
    hexcolor = hexcolor.replaceAll(".", "$0$0"); //I love this tbh
    println(hexcolor);
    }
    if (hexcolor.length() != 9 && hexcolor.length() != 6) {
      println("toColor: Invalid length for input string.");
    }
    if (hexcolor.length() == 6) {
      hexcolor = "FF" + hexcolor;
    }   
    color c = unhex(hexcolor);
    return c;
  }
  
  color getColor(String query) {
    TableRow result = palette.findRow(query, "name");
    return toColor(result.getString("value"));
  }

  void loadColors(String filename) {
    palette = loadTable(filename, "header");
    println("Loaded " + palette.getRowCount() + " colours from " + filename);
  }
}