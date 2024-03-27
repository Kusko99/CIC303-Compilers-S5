package eduardo;

// Token de identificador
public class Id extends Token {
    public final String lexeme;

    public Id(String s) {
        super(Tag.ID);
        lexeme = new String(s);
    }

    @Override
    public String toString() {
        return "ID: <" + this.tag + ",\"" + this.lexeme + "\">";
    }
}