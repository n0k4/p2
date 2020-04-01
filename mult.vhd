entity sum is
    port(
        a : in bit;
        b : in bit;
        cin : in bit;
        cout : out bit;
        s : out bit
    );
end sum;

entity mult is
    port(
        a : in bit_vector (2 downto 0);
        b : in bit_vector (2 downto 0);
        cin : in bit;
        cout : out bit;
        r : out bit (5 downto 0)
    );
end mult;

architecture sum of sum is
begin
    cout <= (b and cin) or (a and cin) or (a and b);
    s <= A xor (b xor cin);
end sum;

architecture mult of mult is
    component sum
    port(
        a : in bit;
        b : in bit;
        cin : in bit;
        cout : out bit;
        s : out bit
    );
    end component;

signal c: bit_vector (8 downto 0);
signal carry : bit_vector (4 downto 0);
signal e : bit_vector (1 downto 0);

begin

r(0) <= a(0) and b(0);

c(0) <= a(1) and b(0);
c(1) <= a(0) and b(1);
c(2) <= a(2) and b(0);
c(3) <= a(1) and b(1);
c(4) <= a(2) and b(1);
c(5) <= a(0) and b(2);
c(6) <= a(1) and b(2);
c(7) <= a(2) and b(2);


U0: sum port map 
(
    a <= c(1),
    b <= c(0),
    cin <= '0',
    cout <= carry(0),
    s <= r(1)
);

U1: sum port map (
    a <= c(3),
    b <= c(2),
    cin <= carry(0),
    cout <= carry(1),
    s <= e(0)
);

U2: sum port map (
    a <= '0',
    b <= c(4),
    cin <= carry (1),
    cout <= carry(2),
    s <= e(1)
);
    
U3: sum port map (
    a <= c(5),
    b <= e(0),
    cin <= '0',
    cout <= carry(3),
    s <= r(2)
);

U4: sum port map (
    a <= c(6),
    b <= e(1),
    cin <= carry (3),
    cout <= carry(4),
    s <= r(3)
);

U5: sum port map (
    a <= c(7),
    b <= carry(2),
    cin <= carry(4),
    cout <= r(5),
    s <= r(14)
);

end mult;