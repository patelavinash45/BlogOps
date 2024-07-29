PGDMP  2                     |            blogops    16.1    16.1 <    1           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            2           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            3           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            4           1262    180980    blogops    DATABASE     z   CREATE DATABASE blogops WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
    DROP DATABASE blogops;
                postgres    false            ^           1247    181358    blog_status    TYPE     v   CREATE TYPE public.blog_status AS ENUM (
    'Pending',
    'Approved',
    'Rejected',
    'Deleted',
    'Draft'
);
    DROP TYPE public.blog_status;
       public          postgres    false            U           1247    181329    user_status    TYPE     X   CREATE TYPE public.user_status AS ENUM (
    'Active',
    'Deactive',
    'Deleted'
);
    DROP TYPE public.user_status;
       public          postgres    false            �            1259    181370    blogs    TABLE     �  CREATE TABLE public.blogs (
    id integer NOT NULL,
    title character varying(128) NOT NULL,
    content character varying NOT NULL,
    status public.blog_status NOT NULL,
    admin_comment character varying(256),
    created_date timestamp with time zone NOT NULL,
    updated_date timestamp with time zone NOT NULL,
    updated_by integer NOT NULL,
    publish_date timestamp with time zone,
    created_by integer NOT NULL
);
    DROP TABLE public.blogs;
       public         heap    postgres    false    862            �            1259    181379    blogs_categories    TABLE     [  CREATE TABLE public.blogs_categories (
    id integer NOT NULL,
    blog_id integer NOT NULL,
    category_id integer NOT NULL,
    created_date timestamp with time zone NOT NULL,
    updated_date timestamp with time zone NOT NULL,
    created_by integer NOT NULL,
    updated_by integer NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 $   DROP TABLE public.blogs_categories;
       public         heap    postgres    false            �            1259    181378    blogs_categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.blogs_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.blogs_categories_id_seq;
       public          postgres    false    224            5           0    0    blogs_categories_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.blogs_categories_id_seq OWNED BY public.blogs_categories.id;
          public          postgres    false    223            �            1259    181369    blogs_id_seq    SEQUENCE     u   CREATE SEQUENCE public.blogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.blogs_id_seq;
       public          postgres    false    222            6           0    0    blogs_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.blogs_id_seq OWNED BY public.blogs.id;
          public          postgres    false    221            �            1259    181348 
   categories    TABLE     >  CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(48) NOT NULL,
    created_by integer NOT NULL,
    created_date timestamp with time zone NOT NULL,
    updated_by integer NOT NULL,
    updated_date timestamp with time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.categories;
       public         heap    postgres    false            �            1259    181347    categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public          postgres    false    220            7           0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public          postgres    false    219            �            1259    189930    images    TABLE     �   CREATE TABLE public.images (
    id integer NOT NULL,
    url bit varying(500) NOT NULL,
    created_by integer NOT NULL,
    created_date time with time zone NOT NULL,
    updated_by integer NOT NULL,
    updated_date time with time zone NOT NULL
);
    DROP TABLE public.images;
       public         heap    postgres    false            �            1259    181320    roles    TABLE     `   CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);
    DROP TABLE public.roles;
       public         heap    postgres    false            �            1259    181319    roles_id_seq    SEQUENCE     u   CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          postgres    false    216            8           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          postgres    false    215            �            1259    181336    users    TABLE     *  CREATE TABLE public.users (
    id integer NOT NULL,
    role_id integer NOT NULL,
    first_name character varying(48) NOT NULL,
    last_name character varying(48) NOT NULL,
    profile_name character varying(48),
    email character varying(256) NOT NULL,
    password character varying(256) NOT NULL,
    updated_date timestamp with time zone NOT NULL,
    updated_by integer NOT NULL,
    created_date timestamp with time zone NOT NULL,
    created_by integer NOT NULL,
    status public.user_status DEFAULT 'Active'::public.user_status NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false    853    853            �            1259    181335    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    218            9           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    217            s           2604    181605    blogs id    DEFAULT     d   ALTER TABLE ONLY public.blogs ALTER COLUMN id SET DEFAULT nextval('public.blogs_id_seq'::regclass);
 7   ALTER TABLE public.blogs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            t           2604    181598    blogs_categories id    DEFAULT     z   ALTER TABLE ONLY public.blogs_categories ALTER COLUMN id SET DEFAULT nextval('public.blogs_categories_id_seq'::regclass);
 B   ALTER TABLE public.blogs_categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    224    224            q           2604    181585    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            n           2604    181572    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216            o           2604    181522    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            +          0    181370    blogs 
   TABLE DATA           �   COPY public.blogs (id, title, content, status, admin_comment, created_date, updated_date, updated_by, publish_date, created_by) FROM stdin;
    public          postgres    false    222   �J       -          0    181379    blogs_categories 
   TABLE DATA           �   COPY public.blogs_categories (id, blog_id, category_id, created_date, updated_date, created_by, updated_by, is_deleted) FROM stdin;
    public          postgres    false    224   @�       )          0    181348 
   categories 
   TABLE DATA           n   COPY public.categories (id, name, created_by, created_date, updated_by, updated_date, is_deleted) FROM stdin;
    public          postgres    false    220   ��       .          0    189930    images 
   TABLE DATA           ]   COPY public.images (id, url, created_by, created_date, updated_by, updated_date) FROM stdin;
    public          postgres    false    225   ��       %          0    181320    roles 
   TABLE DATA           )   COPY public.roles (id, name) FROM stdin;
    public          postgres    false    216   �       '          0    181336    users 
   TABLE DATA           �   COPY public.users (id, role_id, first_name, last_name, profile_name, email, password, updated_date, updated_by, created_date, created_by, status) FROM stdin;
    public          postgres    false    218   J�       :           0    0    blogs_categories_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.blogs_categories_id_seq', 44, true);
          public          postgres    false    223            ;           0    0    blogs_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.blogs_id_seq', 50, true);
          public          postgres    false    221            <           0    0    categories_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categories_id_seq', 22, true);
          public          postgres    false    219            =           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 2, true);
          public          postgres    false    215            >           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 5, true);
          public          postgres    false    217            �           2606    181600 &   blogs_categories blogs_categories_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.blogs_categories
    ADD CONSTRAINT blogs_categories_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.blogs_categories DROP CONSTRAINT blogs_categories_pkey;
       public            postgres    false    224            �           2606    181607    blogs blogs_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_pkey;
       public            postgres    false    222                       2606    181356    categories categories_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_name_key;
       public            postgres    false    220            �           2606    181587    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    220            �           2606    189934    images images_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.images DROP CONSTRAINT images_pkey;
       public            postgres    false    225            w           2606    181327    roles roles_name_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);
 >   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_name_key;
       public            postgres    false    216            y           2606    181574    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    216            {           2606    181346    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    218            }           2606    181524    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    218            �           2606    181642 .   blogs_categories blogs_categories_blog_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blogs_categories
    ADD CONSTRAINT blogs_categories_blog_id_fkey FOREIGN KEY (blog_id) REFERENCES public.blogs(id);
 X   ALTER TABLE ONLY public.blogs_categories DROP CONSTRAINT blogs_categories_blog_id_fkey;
       public          postgres    false    222    4739    224            �           2606    181588 2   blogs_categories blogs_categories_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blogs_categories
    ADD CONSTRAINT blogs_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);
 \   ALTER TABLE ONLY public.blogs_categories DROP CONSTRAINT blogs_categories_category_id_fkey;
       public          postgres    false    220    4737    224            �           2606    181651 1   blogs_categories blogs_categories_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blogs_categories
    ADD CONSTRAINT blogs_categories_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 [   ALTER TABLE ONLY public.blogs_categories DROP CONSTRAINT blogs_categories_created_by_fkey;
       public          postgres    false    218    4733    224            �           2606    181660 1   blogs_categories blogs_categories_updated_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blogs_categories
    ADD CONSTRAINT blogs_categories_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 [   ALTER TABLE ONLY public.blogs_categories DROP CONSTRAINT blogs_categories_updated_by_fkey;
       public          postgres    false    224    218    4733            �           2606    181631    blogs blogs_created_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_created_by_fkey;
       public          postgres    false    4733    218    222            �           2606    181620    blogs blogs_updated_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_updated_by_fkey;
       public          postgres    false    218    4733    222            �           2606    181669 %   categories categories_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 O   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_created_by_fkey;
       public          postgres    false    4733    218    220            �           2606    181679 %   categories categories_updated_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 O   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_updated_by_fkey;
       public          postgres    false    4733    220    218            �           2606    189935    images images_created_by_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 G   ALTER TABLE ONLY public.images DROP CONSTRAINT images_created_by_fkey;
       public          postgres    false    225    4733    218            �           2606    189940    images images_updated_by_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 G   ALTER TABLE ONLY public.images DROP CONSTRAINT images_updated_by_fkey;
       public          postgres    false    4733    218    225            �           2606    181701    users users_created_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_created_by_fkey;
       public          postgres    false    218    218    4733            �           2606    181575    users users_role_id_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_role_id_fkey;
       public          postgres    false    4729    216    218            �           2606    181689    users users_updated_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_updated_by_fkey;
       public          postgres    false    218    218    4733            +      x����rI� ���^l�9�4 b�*3UCQ�LvjkQJuݩ6�G�1�B
���yh��y���_՟p����XH�����$	��~�����wϒ,/�Y�Tt�?y-��^*�Pe�ɕJ�ⱺRQ2S���$E������g"~��ў�#�e?�ͮ�3x\�K�y{&S9N�l"n���Dq%n|ቛ@�(q37cq_��潸�7�����X�$"� nf�����L���7��k��Rx�d.ۙ���K/R��~��{�v�b1O
��2��u�O�������s1K��pKH�/R�+�'I�	_�b*/����JU쫎8�&���OTf.��¿�ّ<�*�x����}��yk� �rϏN�b~Jmq�ʲΏ����5��]y�8h�&x��G���a��,U�%�ٞJ����Td��(�P� ���2C 1T�s�K�
�	� `�jj4
��e��1\�{�ЏTK\+8�(��,J�M�g.���'2�p�.Qd�뗀��T�ߧه"�!���
�?ꃙ��d���'s�Q���$��FD���Q!��"����n��� ��������G ���t*�1����~�~��oɘ �4����W�ցw4���7.�Kz�����%��%~I�r;s�)�"h�"��\��3�a��BD���Q���,O��X�����Ëk�M�¿�ԏ�|���^��~���jୱ ���YR��x�U���b`r�����%���L��^F�>O_��q��A̯t����s�wb�L=����M�G�j�����f?�(�䍘�{b���O{�<�e��� 6
��'�}܁��6���{��ұ��{�E2����~ڋ�8H1�E���(J����O�E6S~�K�ag?�ˇ����mR��Ib8�(�m"�� 5"����0�qǰ&���Hr��=	�l�`�i� �3~��"�A�F�vU���a��4B����9 G�e�ʬL�/�<��7L1R2/R� +|`F ǉ��.��&W锁��1�tV��z��>Eɋ������eޜ�d�8���`t�8�-�$�`�39H,�$�=���H ��E[BF�*�J�g�i�p�W�Sс)�xH�"����7@�HD!it@\W��$1��b���x��#:n�������u��M�.rXv
�O�/�Y;H�v���t_�/��v��v6��l;n"�+
�Ú��ؠV�V�^��<��s����"����GHD��E�#�4�\�cH�4���k��j������oJf!|�e�Zj���'��IVxC���k�p���ʴ�aA)�v��Q�/�%�|�"��cN~!]g��&ר�������AFKD� ��O�G�<!ö�q,M�dt�5��|+
ү���0]������?�]��1~�,=�_�Ӥ��z�x�Hv�В�h�gI���g�!�c�'H#BG�[��R���`���t߆q J��@���/ԯ���yP���e���tz� Rb�
�����z8�@G�rN{e{�8�sԙR�i
pl���t���g��m�x�6M�������+�@p������?�CT���'�'m  <���#� ��0�m��,��g����͒xD6>��*��S}�U���#�T�h�-�����ҳ�o`���c</-8D��= g���������� ��1[�(���<�\ʨ^��̗s)5�H_�#/(�
�4Ry� ��>{\ -`�_R{ �]5�m�������T�\���k���h;'����qʇ3���������0�Ŀdh��>Љ(�I׏d�'�{��
�l�r�u�<O%(G`�+2��+ �*��ǉ��T�6�sd����Z�K�/��t�Da�/�{p~GM�=j�${d��"T,T�µh[�@$E�f�]ԇjj���6'_�>�&�U3f�u%�Zd��%��臩_��x���$-A�Um����0.���0"Aw��-x��6��Ѱ�iƢ:�1^<�4.�����SO�V���(l�0���+� �`�2-���AE�N`͠�e#�-�0bUON�oEy����0_�{]ռ��iFG��z���т��tD�x�_+���*~-��P4��#��釶(z�H��YǴ�W
� �%�� }���k�|p�<26��Hך�@��؜}^��
��6��goM[cfZĩ�"M���,�A�1�����p?��AF I)M�劬��A�����b�g��
�`���x)m�R�fT��P��B��MNP�@�Sr
'�aĂm�2x��>fQ��¼`�f*���<b^Δ�$���yV��z�~�q��u�e[!(�(*uSJˍ����	cq�wĤ��xڠ�	A4b�h\���r2Kf�E��VIn�����"+B0ŀ��DI�ĺ�:�5�Gp�8s�B$�pJ�����B"�W�a���|M�L ��C+����d�G��Y^ax
t6����$�+��*�r�6ڸ� S�Uڟ��S^��}�e1ZMS�`��(��ԁ7�VL�>�n��G�Ӗ����`H�d��ANT5#e<.L*}5�#�I��ҥu��P��Y�i��(H)�TP��R�"���D?�8�м����E*�\<�7��ެ�����Ksc���#ٸ#y���s(u3��SP��ˬ ���������� R�Br�Le<ǻ�=�5��id� 8;�Ʋ���H6&��<ڒ�����I�#�Qvo�<�q9e?�8NPe�_��`g��rb�j^�����2F�ꦦܖ��T��MR�G�K�&��UF��'�C7/�$푺��~�T �@�w��d �l���8���4*"�zd���%�=������P�*��g�*&�rN,1SH�S��I��K�����hM#3k�L�r��x >� �m����m���'L-,�̏� �~&�bc E�6tl���\�{�,+�AefF��zTG��J+K��ԭ9{��+�g��ɔ�{�$�t�;�5�[��ք����m^p5�c��&�̉�
�&��OZJ�ūg��l~�O[�C� 4Y/>DgO�PsK���Ӏ���c����"=� K�����Fi��F`�7�UFZ���{gI+v�Y�M�2~��C�X�(J�A�z���Ň<�Djk��A�y�u9�>��W�1���Ҹ\�ժ�>J�côX)5)b�V�i�H�O�<��:��aFftK�O�m�(�=!3���ZX�	��+s�	C�ކ�>�]�6Z	i��:9�rL��n`V"mZf�Q�UcP�"�?I0�Kbj�> �$O�n��Y
k�E��3?E�e������G��#@7��ht�6�#Et�-��P� �KG�[u�-�`�v�!�N!*�9DڮC����s���
�qg ��ҳI��6(�y+)r�<�R���S�e�# ��$a���Bq�8f܀p'�{�	�����S{�7�VD8�1l��r��y��^q�;)Xm<DiַG��I�Q��PN��'�0�Ǥ��,����G��l?V9�l�����o��!�f+�6;��i��D��@� ��FY_�:'RZ�!�W͋�s��&���@�F�|P��jJ��1���2�2Dg�&NK�"�1�BR��[0q�E�5�� J�ʻI_b�ӌ���BH�I����:F1sM����U�?���"�~�
 ��6�n9?8��aחΊ���O�UfZ	EZ�N]��ަ���Qv�1��ܜQ���DѬ��(Cj��	4d �����$%���g�%Z6�fE5P\:���pE����@��e��N*�~����U�~^-.����e�W).z��!�'�hM���T��TꌢJaU��?`�P���q�6i�90��)���[�|q%F;��K
b�\������ IŜd4��b:<g���|�92Y��v�n��,,�`�w�����%V��Q���w/�^��/Ͽí�������?�����I�x����������?}�&��,0�}��� ^��    �6Ia��������V�PΨ�� �y�NA�@7����MC�t��ǿ��3u�G�Q�ܴw]��1��ӂ��~�[�Z�4&]��@o	g|+q�$F"/���O��4k�����D���d8i�o){��)�ă# N���J�����fӬ�xBQ���Q.�A�_�c�)".�u4MQX�Xө�2�d��5�7��9-���C�P�U���+�#�**��	/����(4Sw��)�8�Z����̗P�JIZ���4/V�� T!�յU�# [�3M�0�ded�&�V�s�Ŀ)eyQpu��Q������5d���A2��C0�� ��D��k41T����t$<h��®�8���,k�\��rp4/w�7IhW�f���r5�T_�i ��E�E'u]�<:�ݭy���͌T��ܩ����`{"�*��
F�8C!���A�i&v�K+3��9LQW�ͦP���	fk� �C��(a�q��4�{��R���l
���r?��j �3PV�"�����O�6Ox	�9K����o�J���i�V�Y(ڱ�(Og�^�߯�:��gm�|ޅ��C?�����n�a�r�~���kP�� �A')��<[�c�;5�9��c��XαY�5M�L�P�3�01×5���NtOf�(�{u��T�n3Vʬ"���7�;7B�ֳj&W�F�@��y�l#���(�gx�0�ɰy��˦GI�yfX�h>���5��A�Y�5�U���G�Wko;Y�:M��W��}�Wt�����tS?_�H�x�K)�(.�4�`����7"bͅ�F���a��`g������g����
Pc��
�W0���r�� �q~���$*W��Ĥ?\ۀ����xj�l�a}��|}�}��H���)~v���_�¾�2���:*�]	���*�T��k �k���0�>r�͆ Y��+��u氎�����ǬC�����S����j��~�?wH}�>VT�y���:3��l�>I���w�����-�	Gf/��f~Zr9f)�2�{Qdn���1���'ܿﾺT��U6K�Lu.r��r�e�������t{��?,�J���{��/�ĥK�v� D^��`��b�b�%a޺qW`�-���Hc�_�ƿnq��������[��ݖF��$ѭL��T�S����T��Ө�E0�4���ƍ�����K�o��QE��??�稠�P�ߣO�r�Eȑ~'��{�¥��6z�r$k�����wU�˭Þ�<o�q�chGj^Eǣ3〚�7~AE4T�7!�b�X�0�U�~:�����ud	c���z��1���31V�ܮf~SvN#mc,`Ik��rg��������1�%�M̜�jX~�Z!~�{���G����O�8�!�6Pl'>���t�����cZ�tN���T��R�-w��YJ���<s��d��.~Q���Q��z>��8�a�	�Q����-�~���˗����e���|'�,��h��6����m�n�	�y.��p��^a�M�tK�C�@��v�ɺ��r�%�T��v`	j�I!g��/���{55����W>�tVP����<��27<X��?��R�������ݭ�̉q~Jw�M�͔V�^�{~a��O�9Tu���P�j�8�������,ڢ����7������&zޑwмm�NlGL���S��Z��\�C`_��X�b�[T��eo���cA:f��Y�X��E".��VZ{�Zoc��6�o�B�wp��P3��h�����k�����ė����a���G�żh9�9�|+�c�	|����w0�C��=\�ͬ���'���rﭣ�^0l:,��8�ߢ�v�h���Ջ���܊�<��T,sl.7O����.w�=��k�TG�o��H�ٝ���te[!}5V��ι��N]η�M4 6`'�c�<��f����6��zO��զf�<>j^���d.�"�j'�0ӁD샤����(����M�(��k�J���<��x*�����;abǼ3�D��:�*��q�������TR���K����������Ω�o�L~��Hw���`mcFR������=o�*����C�k�j����d`����!i�_Uji�%�@M���)���z6���S߶����Uk԰�wN�Lj�j���<�"��`���ڨ��hh���5�w�`�\3��U5�z�M|�Ԭ��l8�Od־x�d�1�!V��h�-�z��w)/�kq���{%��XW���>�v;���`�_Z��\Ы��wz��v��ӷ�`ԟ�@��6��c{!�$?J���t�d*q�߼6(�:mT� x��J""����]�ո.ם�q�������� 
�QpVߧ�7�-����ө��K��ع(� ����l�fAG`U1�V �x=�|�`2ӓ��f�9��e��=��Rْ�@�!�)�hsk�`���JSƣT�Յ�U�m�U�4�w.��}�Z'��&��z��e������v꣯"�%[�̒k���H��]���f�ѽ��n3 D���V�v���ʷ��y��(���C/�H��2̔i��됓�X1�Z"kR2��b��[���d5�E1�� �MF�gԲd6�	�:ѭ�B=;��{�	��a���}H�+'$� 5��1���w @��P� �:�
R��O�(`�#�HLa-e�'�8�u瀊됐�R����'R~\'ͷN�DE3�R�N��1��a�!��xC�N�ΰmu�H��.v��>q#3�+�A�c�Wn�Y�JD�n��y�p K�9�`b�ݚR*�Z)}�;��������:�x�AL*(|����|8@�}b�m87�yҾi'��$���̰c���ٟ�|�Η@�8��Z
�'�⧩
�bj?�?��h��J�yy+��� ���a�����ݓ�-g������uX�v���5\�{}�z=ύp����n�R�G�����A�����\�������t������s����y~��	k7�q��7����ì�����U�ٔwB-g2;l�n������	Ƌ�T/b��B��w��.E�� D�h�C����̱ʌR�\��8���ِ�VoH~�b�P8����!������]�W�������-�f���V���b����	j�a�F�"1�f�Q&�������+O)Ӕ�q�2�S90�19����Lr��М��jMΈ+TLG����n=SG��z0�j�h���́�;�2�є�q$z�.2O�y�0U_On^��NC��� 5�WA,|�o�ˡ�c�
��)�ۣ� ���w�D<*�
��ȧk�����!�j�5m��l��*����^�4�@�Zױ<�'�/M@W'U8-�('�SSL]���A'�#�<_�-�A	WJ\��%�b�di�u\��t�q�����Y�SN�f��Eɜ��G���	aI56��cP%��O!@?�r�����������2ݐLBGC�vH��	�4!F�����N~UyG<1\�k;m��:�}VѣN�F1�&@Y���Y��f�*�%�u0r���4� =ɢ�]�NH����Ny:%5�6#ٌI�#�Yks=7 ��h�M}�'�T��91���ȏ���5�k����uؙ��\��:j��"T�� ���]	����^r�[<s-Ӎ��T��&n�VS�3���bGn3W�c��cUUN�Gwd���'u�eu��0]�½d5b��fh�ސވ�+��4ũ/��!�1�u�x���؊�`a8� �M����<�U������1�+���G���mIVs�'fT}�2�v��z���p�5#  �7��3o��p�m@�F �+�թj����6������.fu]�	be�V�H)Oȁ��|w��5_�2��cGy���%Ⰾ�Kt�G���cY_�?���.u!��X��1��nEɶ���/A⇀�N2�DpM�ր�B��?M|v�v���p���O����i����c�\�qs�!zv�z�L�����>��̴�"OP!�%Uh    ��7�gZ��{� {!G/��}�Q#�w��YXOVL-��ZfV������ق�g��]9��ъ�W�됀���6V#eǀ|�@ȶ�<tGo-ْ�?��#�,���ˈ��X{�1<ZG *Ri�r��r�G����V�T�S��%usO��3"��ާ`����z�O+񵸑Vv��K�א��C�
pi�㜻Ҵwم}�e>�mp����L�ąji����i������� 'L)K#Ue�t�M<���6&i���{�X��̴K؃�1@����2�2=Y��Q�l��,eH�<�!��_N]F�=��:��T�q�OL��x��)��t�RVS�����~���2�qGsw(%j$tO�Y$�r2e����녭k��d#�0$vRa 8gTU��,�`��Ph0׮�����q{}�ĕ�a��0��M���5��ϥ��<�.�>�$�[>E'�#K ���T��aI�=u��&O�+0��YIn���+t�پr'��1H6 B=��&���ͳ���� s�F���Ux�g�oOɠyOx��j�;�=ĳfE
҉�m����"�<�3�x��a��܀){PsL�(O����q���?��
vlpo�`��sAy�Ѽ�ޡw�l�=~~Q�Tk��M�#6��Tۭ�I��X%����x�xU���f&L�?�I@^���}9j6����|��DG��A#�=Eķ-	�@���b��hPJ���#
n�U�����TZ�Kⴌ�����H֋�W�J�Ne��)�?a����+:���C���̹t�IOg��y�b?���#�"׀2:=��8'����r8X%6�L4@`h ��Q��=L��E8sIo?�{6��2���Q3���=+�_m�^�;6��RM��TtɡGԶ�2�A�9~]��|}�j�c�˔�$r��zf1U"�$:�������l�ީS��Y�G���:Y��ҧ&�O�<���}Q뎕S���jC�MQ ��1�4-�<�Z�����e�Sm����=�Ld�[���h��H�+�ֳ��(�)�4�/�Ng1�j�+����(���X�M�sBQ���[(��\�0���h�
^4y���m�>���2Ձ�2e4��,Ц*a]fGFu#-5�Oc�3&'c��杜4�B[5���AL[�K�����3P Y0F�(3�g�(��QK�)��e���Y�8U�9�ЋT�l���aIA��%>YS��+���Au�n(��<��[OW�,�X�}���`#Tc�籜&�!�+�l��rg=�a���Β�g+b�Y3�1Ї�h��F�#��=[��f��y[��6늦DYg5���Nkn�gJ��V�_��7eK�'<�������N�iWR��6����DuLQ���GWz�pN�d�� oLy����:�Q��ɭ���St@6Rp5(�lN��!;	Gyݣk���H���L�#L�!�c�]�^n-yÓ����4?+����3�A3U��>��ZH���N��0 n�X�yu�/@�y��z�3����y�I˩֠Tq⪤�`a�Ui���M�j@�l�3���t凜ׇ٘�Z��\ �baKm4�Sj�g�N��r��9�T�=Yhs�Jv	zkV��������K�1<���	��� Mf�4\7�O�ɔ�<�ⶇX�m_����fF����T0V������-^Lh�9##8�qYԧ4��:�=*�-K��)9�-�G�^'��ue��bl���4���M��������3�_��q"u��'�K�+��P�	�A�0��H@�y��y�b����`kZ�ß�K�� ŜѺ'zᐴ:0�S��dZ�T#��\�s	�9�WдX]TR��k�ʚ��k�Uy����:1����:���^�xޚ�j��R1�'ň�E ]��X���� ��q�7�<�d�3���d&
f\o��N%��S�@�!#�%D�uFӭq6ҕ�
]]�A�B�W��h���>�3�a��V1 *�R˴M�/������ 4֞���x�)u���0_��J!��e�ïɵ"#�gBY�@S$����G����~��#%jFG��a=����P�5��Н �Br�$�©v�M7���G�Yc�Q?�3W0D�ZM&s�&��ưI�nJm%瓉�	꤇̶Љ�8#�ͽ4�Q��z^+D_R�4��U?�RS���L��FH�c&��9���S_7I!&�Y�u<����:�g+�I/
�,�e�y�~�aAz�q�]V�����v���Ќ  XV��M��/){�\h����zC=�4 VS�5;��U�˃r���<(/��>_+>2(Ư)��nY��r�;���o�̳�dʶl���˶S�&	Ֆ��6���g���z���!�Y�IZ� ��YV�V����G5��b+z8��e�q_Mo�]�pp�9�����Yr��]3�d(b�"O#9�b�鉃��#��_q��cE��O�� C>�
��GӾ&4���{���q����;�ޢc�H���g�Y�zS�`���T����9a�I�Y��?���P��5�҂^:�y3�}�$�
vn���c���m���L�V8G7�/IA�V�q�)$��cF&�Rž����Z.�
*���Z�Thk9���#e*��JM�P�-�P��+�΀�����ڔ��N�9�;��	��K;MefS��^~��u�4w��f��+���f5KW�︸�5��%��V�j64��,��]��	dA�ʒ�
��p4�D�b�d��!ͧNM��_"N�����r2��OU����K��8�+�x�*�����gC�*g/�������я�$��VD�A�xK�tXC�`�E�p�'۝DD�:"�QU���L͍.#11�/�iٖh\(l_O�3(+lܐ�ڄtJ`��`?׉�6f�[�nͼm^#�E_�J��Q�6�u
G:�����u��jhD]j50G�<3��<"A�_t��hS�%�����؟�����NLt�`�23��F:�P�,dm�)�I+$�G2n`�X�b�* �&�N�X���)X�/�d�eO��z��zE�KL9%f�g촜N�WV�K��Lܣh��ߟ��0b�aD>QqF�B3.( �F�Z�|-���4Ô�'�&���� �Z7�
��XN2�Y��X�7@"n�@����EzJ'֍]s~E橏`��	1���nd4h�����$�S	��� 	K���'����<�

}���Qg ~yt�,;���p�1zi.o��؎�e��_�g���v�?���x����xkPE��[izW&������&�'в�P%�n0:i����|M���e_�t�m�e��0	�h��b�Ar��d�1�؇}�����.�}���F!i�eIT6������K����YՅq#���T�*M�ģ$��1�Sa䂶��wf�d<��gv��e�h�w{���}dmz���A{��I[��퐴X��~s��D�L�i�[S.�vEm;zݲ���}��SXמ�Va�����~�py
�? �t�q'/��v,�6��=�g@U|�r������h��~�v��T�/>G!!.O�B+A7�\�d;dH�Ia�B��M!m��]��N�����1C��>��n�+ql��+]"����qIג%���I�p���_�YX8OO�`����"�k�T:�	F-*��9�,���3�E�3z�[�R��ں����1.�V���@%"�_(��њO����G�{'�5YU_-��*Ir��{'-��/jU�.�bH��m��5L#NҀ�����,���S�����a`�^fܬ��ki���H����!)V����k$|�I�Z$[BE�)��u=��q�`�	%��L�Q�Z}M�����R2Ը��p�*}P�MԼ�u�[t�Do>L�ܸ�4in���h�r�8>O }�xu�L'�k*I7շU, �M��G���<����Z�<�e���
���A?l����g�~���3�8���8���@'VרV�v�n�@�<�K���\ׂ�X�Tj�_�Fr��8�w�CZU�;�Ð*�q���5�>ڎ�5��XKŧ�G����?U�����mol5    ,�X�rP�e����Dnnm��I���
�M�2��8%�`�������=�7θ��kUd��I{^��;�*���Ia�B�]��j؋���
߁kpp2M0�l֑j`�
XW�l�"����k���G�BK��τ�ɩϭ[Md`��c�Ub�y&��W���*,4���F�U�8�MW'�P·�;�e�� �%u�/��;/���3��L���:��e��$J�A��\�*��`Ǉ�eß�����s�1��2�?���;�$urt�KJ��3���ۨ5����!�cOQL:XN�a�y���[0�r�UF���)wLQz#�Hg&.d��S�I��T����\"6Mm$�z�'/P�h��UFf��LqF�E�Dq��к�G��9\����P'����\WL��86�aհ䒬�Qp*�����\R�MP�G�q��H���.(�9���(�l�'���{��ѝ��`sL����E�]����Ui��C��g���t�}����k1�n�?Kė?w,�;�c���%�<u�"��e}O�W{��׏�"T����_&��I�2��*�v�1���5�h�qC�(B!�IJĄ����I�O���'��W:�6Tѣ}�m���� 8i^��s�t��`��A�/2���CP/CO�G��τ����`�E��T��3�r���4|T�H5�b�Y{2���XY>�ϓ�("> �Jtj�ko�t�8��m�6h��ڥw�� î���hf�)�+)؏�A�!l3[�^i���/�6r��HW� �8����Gm�S{ m�a��{Q����C+M��J����N�]��qL��vH���⸆�b�� IPy0�v`�ɜ�O�䉩5�T ôP?��<8�M|i������"����V�X:*����i�Y�]ټ�W�����Kj��.i�����T��/A! ��B�y��i��҄Q�>{�p����h�{8з�����{Re�Hu�P���C��Ԭg��[2��a	�n��|�7{֨�G@y�\����&�cHf_���,h��&��Zs�j�l��������<�Ͱ��v����꫺�������c�����[�p��9>R͛$�2��kq�+���c�"�2�[��8i�G���AB.�dTu�S{!e`+\�ntN�&_���3B��0��;!�PG1�Bl@	Z4>L��X��D�-�/�n-���ZV�
�Q��o�*��6}\��mXt��_��}�{���+�2��+A�Oy��,\���=64�h
���=��-_X���kw�yȮӑ}����
�o\�3��3�]
��r%8>h^��B�G��l�w/��>��i����\ʅ��;f6��2��~�D��v��52eF�cpP�P�r���O��jLb���~��Avq�7�]��"���\��/�jk�p
�]6���<Z�ٖQ}rے`�eB��'��c���`A2�F�l��Dp3r��d����I�L�װ��MJ�G��)��͠��I���qP8�����D��v��_���³~�5e�G{�����Qoy�hy��~�O����;��¿��p�Ϲ�CWg��7:i�_�t�+���;O���#�K�.U9p=�JI�Ӏ'�+6R�Utz��cE/E�(����ʚ�?l���-�~]#�� ~�
x��MZ�[6��a��N�T��=�h0<�~4����t^=��9��B]a�6��˔�Dc�'�c�s�.���g|��T��3̿�-g[5Ѧ��I�B�f~����MР�*<�[^���_]cE�G!JA�h��v2�9�k��$���|�di����hMg��ٝ'g�ߡsB�)n�����M�a�(^�/���M�A8�d;�m����X�R�)̇A�%G�  ��A����`+ yS5J��Y�$t�����p�kl��un�D�;��zG0`��0]`x�x���O; ��"_�R��p��L��0�8A�&tw��`�Ƽ�)��I�h��ӆ�-��M�:�8��wܼ�<�Ё��2�2�K�4�Ar4ߴH������p�t�KlP�L�ʢ	'I�%��#ZB�4��0�Y{�&�����@Os'�ޠ%aZ��!�@h�eɮ�tC-��C2P��e*#��kMNv��S��"���u|/�MVZ��7�9��їf�6�Cձ���`��_ܘIM=46��|��eX<7�Ph��H���)�
R�e�e�dK&�pa(�7<���h�<��D<R�;u��A��Ep����U���$���(uF�0���b�03nt��^[�����^����t�9d�Y
'� S."i��l~WX��:Kl��͊���3��g���z�z��vU��~���_3��n���o�� C��N�=$8��/��T����.�U��]x_���B�-;��nߺ�Ko���73�W������2<Pή��)����o0�\�
�nh`�$~~5ɚ�_㜑}���+��&vN��;n�tZ�՟Mm�����ܸ�z��&}z�oh���E)���%Nbl ��=/5��^�Oi:E��O�YYH�X Z��s͍](��rޗH,Rm��+�xj�֝Z�EiH--��u�5��K��M/���=�.h����Q�7�~�y���)�û��>H����z X��ٽ�Ǻv�7�^o���q����
��M���]�����-�<���UjLMQ]�N�Q��2���J݊�r�7/act�\0.O��{ݖ��T�=��W�����F:X;u_���l4��A��7R�F���S3���.<ك�(|YN�5�r*o�R�U�v�x|:�c�sP逯��t5dd�i��!�;��CS�0�3�cݼ$JVQҝ�m"��f%6��4IfUd�k�y>�81 u�	&��ݘ���$�?�1l�9w7�.6l�8����:nџXSGn3��I>&d6EJ�R����K���!��'�%��u"_��x4�sa?��9o��x��:z~K��r�J+jcn\���lPrX(Dp��u1�;X�޾cy�Ғ�n��aȔc��ui[?6���2�H�C�����xx��P�i'�"Lx��Lo��1NE�C:#��W=-j�!�j��r�G�Qc��AÇ�S������\�tq�!,���̅���j��K�'�Dn:�#y��cG�p�����R3%]`^PmO��P�#���lz������E�	����hW�#W[ޥ�@�4O�];Ļ�ZX������;��?�����'���mdz�J����)5�|�C�Iizv�:hWFcL�L31.P�/cCV�i��#^&3����Nty�'�Df�B�K*��c�Q��{�<�������}���%NtcVP���MhEs1�B_��i0SE�pQ��e�v�oVM�`�<�ªaCX�6FI�_{�l�4��6(0�H娑�Ь"_o6��@rjۏæin�9,�
�n#3��L��D�q��?���y��0v�Ph�a�����KeM����@Ҝn����R�s�*-6�T^��g���l����𨻽I�Uܯ]��'� �"��a�`�g2����a��D_ee�	y�)��q�*���M���z���W��.�����8���O5�s��L�Q�_js�ҜgI������P�_�#^#�3���w��$�~2�Cn���X��n,hĺm��SÊ��'��c	�5A�ބ4Q喾j`���2�9I+x��l^��ԵG�Vl�d����`S�M)�;Of@;���t��2�{��bxյ����&Af`z1���`/ʸ>�s�B��(�g�b
��H����$����/O�>��P���w{�x�>V?d�����^�;�vf�ݸ�)�|	�@�{��Q�$���Ao�9:8���T^0�&�v�;�T�W���%��xA�{P�xB�����s?14������tꁭ�ݏAxe��HE|#�L99��oc1�H"��/L��s����g��v��q������N}�	92F���b[�iE<sV[�α�\�	���Ǩ;:E1� .E�a�K�'S��G@�a޴�Cv��ӭ��L�,=<�T�RI��ү'������3sG��MÔ8    x�����r�9���t��q��0~�&�9N�)b�:��0qW��z�p��=�<����i$���U�@��2�%�w�	�_%�t0�3Ձ�ڤl�%T�u&i(l�&��vNEo�i��fhx��s�Q�
�Ld��o3��XZ�8�n�H�+nP�)9hRRPΕ��M��evY�n��b�:k�T*7�>9��ɖx}xpx�x�} �x=))�T��al�zh��SLɥ�%Z|�`A��\f�Ι�9�d�wn���38v��SB6��s�5�������mz�oT�wi߁S7�T2��������}�-Gl8y��T����V�[J��I�y��M�&G���#�*��d�z�S
߳i
gx)hJb��K�Z(�ti�Ґ01j���dN5F�i����z��3� 2�����XjCν�W���N$uX�u��u���S�_L+z�h��%j:h���t�uPs(fB�AFN<��"�U�; ���� g,6p�c����!&� �u�w�K��}��W�|�*'<�q���I=��pv����:R��x�E�N'�rh�xr�Ia|	aJ�t�8�V�s�ɓ�{y��\�wezp���H7�3A,`h7R��c����L9�)�V�jؼ��,y�Q�Rr��a��蚊�ε��r�F������������;�/�Z���5�]ˏWg�F���P��DW9��Y.��W2��=��!�xW�U�6�t@��c=��hkԯ@�卤��I�݈~�?��=�H�a{��]{�oj�i��y�K�j+q����e���^[�=Q_(�t�Z�3f\�4>���X(3�{g�g����.���U��_4T���P�<���)e*�Y��o؅��2Miڭ�4:6��y=�h^�x0ꫦl�<#[���{�Y>T+���z8>wh=<��S�]ŕP߲^n
��w32Y�;z.��+eU'�xۇC�����|W2����C��&8���56��Zx�g�b@�Fe,Eo�:�_���9�<4�9�#��zy���W�(���0�����f�+���:F���gc>G�>k=�ל��](�9��)k���nwԘ�?kF��$_Z�ߓ��u�:��=��'�V��rS-��pU��h�Y�cJ%��C.[��K�&�N�t�����#�K��.���гVl١JM��L��C����Ԍ*+��\wac���_PC0 OZ���F'n��]���y�-��3�.k��M-�[�'��'IF=��|��{<@���U�yH�-�0�Et��e����S����Ak��#�Zo�r�v#�[6wnf�9d�Mgd�%�ed������J��Ӻ)&G�i�󊳕]w���(�u��>�R�j�����œx���C����8)�u�$Pݦl�%G@(D�]j˄A���#�b82�mf�r��K��Hy͓�ڗ��?�D�,%5���#+��n*yRD���q��ï�԰S�[����Z��k0R5�iP��o��3:n>������yc��G^�</.DH�H��"4A��vC.D+���2U���$��co/��,lLK �5�����P�����B�%�騳Ha!��f�ien�He8i/�c+���(q�o(5�j%53����毣��1�X�q��!�7{�"٥��0��_c�qB���~��YO]P��J*�L�)z
㳣�n�Ǜ���O�D�L����#�_ʣukř��~�J¥d���s�\,Hɾry�CV���	��[�[������|#_\�� $��iO��O҅PŗJA�u��X�\ě%�0��po2*��7�\ěL>�WW*���U�iԧ�|�Z�)��$�^f��HO4�ѣ�(X;Nt���㷜��1�#��A��(2�k��J��T�(�l�r,��gjQ��{/�>�o�����8;Jv� X	Ve�b�D�F��u�9�R�pV�ባ��`V�_��hgO��A��  �؆<�7é�����������d�X�;�
����ޱl^WH@�2�6b-I��R��X���7��@�,8F��#~Ssk�O)*�[z���W�>[{���`@�-��4�$Ō��P�ʬ6��-Ô��XR��՗t� ��@��\s�Zu1Ov5MN���t�|H��q�u�B_~IO�.��U��`xFF@�sEEn�@+���\�e��W~�7������_����FQ���K� ?5�������w�5 o2 蟱	K J�9���|ȬN��]�=}ޜ�D vwPڮd1�X@�J�w���=�%zlH>}V��P#���MGs����6���"�U�AI�@��\6y��^�*��ͳdp���!�vit-vĆ�섲�b�ͳ��a=��53%̐�<5����It� !l�(b.�*Ik�Er>�,:L��*�2O��~R���j��<�Rw�Q*��J���[�(N��;9���產������e��d�P�����\&^�zǩ��ǧn���vįش�x�a��X�"�'Hg;�ǎr��Ψ5?�Z��q^�-J���󹧵)�+:�O+�#+�g|ZDyHT��1"X*J�y��Q�t����_2���N�ed�՘eb�������q <�l�(4��F��Z�����/���-]��j��pߺB��K+U���=��Pjʒ&����IC��Eq��C��c���p]:��R�V1��u�S���8�P6'��D�iˬ-�z*(jݏ���Hd��Z��ɱl�.�8����i�9%�#OJ�/�Ġ����;>�j��6�]l��|AC1
|�k������5+-�E�9ڳ�H�2s��̶̶��+L�g���w�g��h�@�$Hv˩���v�2��]��њ��h���K5���{��0cMa�8��K>?}�D,�����˧�����������۫'��ٓ��[^�zz��#fńY�ٸs�dƫ���Q��1�5�]6�Վ���b���Ͼ(|_� s��u�����qC8[�c�Z�S1e��x�O���Ie��x8�:�{�?IVO��V�x�������<��O��!��1 F��n�E�a<�0�p63���F����%��ȇ��a����xT*�1�O�X]�=���cz��������
C����=���G��~K�F��\X��!2���N�v��`����}�I���z	a�폷$y�K�,�]=��w��Y�F3���#�u1L�,�$�ۧr6z�%0��5�#��	$�M�� ����L��{@�s]�q���B��Tԗ@�la/<�ߟ΁g��*���m��lp����od�]}����M�σe�}6�����Ҳ����>=e���oO�����{��(?5;�V�}���Փ׸�16�M^^&Q�o�A7�H�47!8i`*�kݤ��'�d�g��"vh���@0�� �\4���?��;�eJf_�͎����� O ��Uu��RmV_�@��ڵXk��$���T�n2DLK�� �Q�� m̹���Ʀ�&ߥ��x�[�>���9W�ak0���w�u�z�n�y3^#S��S�l��r�u�-*�O���-!J���u	�?�ay�ݢ�9�BQ@5 ~r4j^��k��-c��'��ZR�*����h>���1�jΙ��>7+�%L���*�^w���r#��f�fnܑ�ވ�)�����qѢt29���R��`L�^ܦ�fD����?���4�r�u�����N���J�a��R�C�<V��C눷�ܔ�-ӱ��EWem)�g1�cq�F��mx���Ӹ|�S}����b�������
�k��ػް��8�@jKwQ����u����j��-��;Sq[Wb�M=��h��l��}g`Է�޺�W�����5���e9̝g�q����2MC���k!٫��[�$+�[O��K���E�^��,��XF�,t�Կ�YL���
_���O����������WI��3�I�K �E�_bѢ����-����\��<�����U�z�UC�~�p�ڌ���V��gI�5f�~�I�;������x�ĩ����T��bL*��K/�}�    ��;�������ˠ��\����Ԗ��Gǣ��l�u�zw��ig�9��+BQ�^�9���}PE�`�mh��*˾u��S;d�����3�j��*��}����8O���|����_����+�H�p���>�����y�(�V�D�.m��:��(qWQD�Z{�̄�a���MBKW��Hb>�m��L�ԟl���=��1i�,)�|�����N��&h,��a���`齭�9U�$�[������F�W}��}�RVG��۾���h�3��:�\��;-�FK �)�������X�'�¦��B�(*�M��P�M��>����MPeCF��#�3���G;݀l���Ƭ�vKc!Cu���ј*Nht�9m|����Wլe��$*؏\+�Y�l�5�����܋o�4�o�)Ӈ-�nS�t�F���|߉:jg|{�yv�3g����sq���:w�!-��ʋY9����'v�g�{j�sN��sc"��=�/%������R3��ݘ&�ֈ��k�톧EVO���?���w��?Mǉ8{�¡p2ܾ���9��k��l��V_	��3h�_����x�+S�Th��Gt���uG�^SJq6w�w������'V�8�Y۸ҍEa�h������U��?>��-w �z��~� |��9�L�����h�p��P���/t��/�#r�(}������)��:5-/&)��A�(8�K*G ��zo�֝��E����������vE�خԘ:�gT��LЦ��4Wk?�oL��ZK�%5������w۫���H�n��r�C�����-l뷗�5?h�q����7�Q�PKN�%[zV�'�gn� ����J��
���='�����Ŵ�8>lnə9�s���F�?<��P|���,M�spBF���a�������"!
�)j3k�2>!�察�A3��I?h�.��#�Z�i����o��o�V�|�Y�͠X��Z6�+�?�w�	O�&2��Gu����m��킖�oP���י��}{�yߐ�=�M�j�	I�M�F(=[C��vZ�����)��Sdo!Sڍ2��CH����qʺ�<�`��WDl�Ř&�V� &�`����[I7M�̈́�3QV݉��[g(�E�|a58� g��%A��$ͷ*{H���D�y���]���yw�p�r�C�Q�� 8�%˿�Πz������t�nUR�4����A0hv�tf:���+?.t�ӳp�S-��h���e�Ye����]��U����M��?�î`o��@��v��V*�ا������4+[:b+�-�]���w\l4�f�/��r~)�Bl��M�zAZJ'�L�B~�)n�C���%y�'�6�A5��vչ��ՔY�1z<��M�?�9�3>�4Ri�~T=���[��j�1ew�X���0��;��&afw�&��5�H%��L�Qb�R�2U�-��_��%�w�����r���L����$H���� IWɦh�n����/!	FJ����e��%�t|�쓌�첐�č��ζY�U�ۜ�>�+l�;\��[ߡ5�Bh��y5Am�'OɄ�<Mm�62J��=��y���v��xd�Ϯ�8�v��k�xS��{�}[�ӡ�R��%�(ψ��@&]�fg����=6VcD��,Դ�ÞjP�����Y��5�w��`t�7����܋�Ը�p�l��c���~��~��+�2 � 2�b��q]8}��ڭ$]W�iz���ȭ�`�}t�ȭ*ձ����)c����Z��r��Ė�6Ũt��u�H�
Ǽ݁�:�����D��X��w.�I�/Z8�o�;��D7���'�̍I��*���������b���Vg�ox�x�]�.�W�˰3i�=�*N�.�i�a�{݀�����*˦7��(�d;��t�'.'���X8F'ߨ?�בk�J�I.W�ͯYN1�ʍ�sģۯ�xp��Q�1��o�*~�&v�>!O�hb�FX����Ǥ~	�؛5������1&Kl�~-j^|���Cu2�&4qSF�+�a\��٦6cԔ�ၛD�av�ȗ�o^�oVE�"ŝ*h;U�t˶�\>�q��k]�q��/������n����!<��:O�x��?�3�;:<���V��wkΒ�BSߎ��@��@��)��Ϟܕ�t��߉���~C�����8O3�UBC��#�dv�@%DX�@�"��\���D�	KߧI<n�V�T\p�.+����*��]i�������}�MN�b���L�O�J�5��P�9f����s�1�\u;�~��ّmWEz�D�T�E2����9�{6?�Ed��z^�~�!�Ұ�[�em��O�s�1��z����&k������s�&������@���a�t;G	κ��FZ�L�M����u�:��ejl�3�k�{[Z�h�T3�{����z�HF#E��^@�rH�Tp�Aae�0z)�y�����2=l��x��$`g�u�:�Pw[�ȩ���K��i�����:�������R*=��#���;��i�j-����uʦW+U�aC�QoT���Wx�R�Pw�cE�'�9��Q*�P
����5+�4�@M}�dP+�U��R�������) �E6�2�>��79����ߣ�A�;�.l�iw-���H�(�u���G^V+sL�km|1	G9ڕL�Z�zշ*�~�!f��e�]y���%�;����I���4%6�Ѐ� ](q�}��X��9���"'���5��5�1�����Gb���ҭaՀ8�}�
�]�(�6�^��(��,L���R�?��U��Ȋ�^�WMq�oX����L[M����~c�cW�[e����K�7����K	cY�A�uw5����$�7K;����V�z��v'�xk�K$�M��z����X��} Yn[%��i'�;������~sDĚ�ڑ���-��Ȉ]&JvJ>;�-u4eq@O岿;�6���>��}s�;t��6�x�z6ͥsl���N}�Վ�k�f�� �����v�ͳH��^�[B�f�'ݓ�O�p K�e�͓�uGe�k�d�m�y�k������5����̣#��桍d4B�u'Of��q�;��ۂ��l7�qƳ�����щ��ݼ��N�m�:�n��l�z�%�Q��a��2�p���5���
0��9S.V �9���SU�=6P�܆����3W=�&I.��o�s`�R�K����E�!Fr�c�ntb���t��u��J�ݶ��w"|��he�
�% {)�G�c���M�߈XN��Z������xl��4g�l�Z���)6j��Ț]�Fd�e��Ѱ����Ӱ���_���k��UR�8M$wg����Jy�1��,���v
��כ��t�%���Ϧg�����x�\m����Ao�?X�$�=8ij��m������z�+J�ьݜ}���ה��A�T�TB�;��R��?϶м3���
�p�O�2ހ��"gޚ�텔�5��C���N�u~5��%I��+fء��n$ u��>����n7���3t֚�fq��6�NG+�����em������/��l<����>������VUC���(�������:zr8l�}�2e��ISzR�Vf�OU��$u���O�M�Y�~�	�V�'�iN.i��Im�&h>H~s*�y5������	�I=!�SEi<e�tVХ
�Li�&[ԇ[=�%X[�y���h�Im��N$]ج�-����"h�4��l�gg��k�|�𜥇S�=8M��${�,Jț�z�<��MU��f�c��̀j�k��	'�)s�'�`"�� ې95�$�!���L���2':�-��oЅxK���I�3�����5Y�>�_W����ر����cqO��e�:=�s��� �-uC�i��[����(�;L��ְͥ�?'%�"����B��l�1�3��(���Ti�<�+�Q	_���&��0~(����K�Y��.T�ȯ�t�ä?	'�`���ѧ	\���Ľ���X�]���^7��6	Py�=8t�!��i�@����,�W��4I C  .��&�4����a��8CQ��J$��I�'�Z�B��8�b"7`�������W�z��A�3��%��UѨْx9����u��H4%ٗ+'Q2[����d�)�|+߀�IشJf�@�Q�y���u��\��pB)`��(@ Jf$Ef)F�|��ӗ�V�«e?�A�X�D�Q�|����4��O{��W�iD[v3�1���C����RLE���A ��+�����%�KƜ\^j�/�pJl'�1���5S��wpaN)�p޹��0F6EhR%Ё�����?����u�ȨäP,4L�Gi}.7b�I�F`0��������%eL��a�?�<m��8T��e���'K����}�r�v% �Ȥ��6G	����~J�8/S�ܗ�e^�Q������������t�ЉU�`�G��' ~�<X�Z_?Pͳ�������������[�of�m`9hY����`������X��w�3�U����R9��K��������~�����'�w�`�p��z����ﻇ��/�c�K����9X��      -   �   x���;�0���9;j�w✅���4�%MY@���-j@�����F��e��V�hM�:(���3Iu �zƆ���/�U�� � � ��禞�����E0@E�
T�ޛQG��ρ�� �P�}4�����������sp��c�z��#�*Kp���>rJ���      )   �   x�}��J�0��u��˄sIs�Ӎx�nj'Ղ��L��P1F��?�lE7/�q(H����7h��F9Do�������%��.S�*D`�5mK��Yqx��cs�?N�2��b�(�U�"�E��ؗk�@�b[���E�/}�4L1�����w5�LFI ���mJ����9�y~Ni�ؿ�l������R�A�`���?�D7�K<���KS�`���6�\c�d��JJ��w��      .      x������ � �      %      x�3�tL����2�t,-��/����� D��      '   �  x����n�@�y�,�U��՞U�(�!`n�"E6��8�7 O_�D��M#uu~���_�Ĩ���-)���~dr�ܸA��o�J�*�j�����E���a.�C*ź��^g���ãݐ�`Q�4;���A0a�X^cvTQ��D��+�����<
]!')|� �}���I	*L��0��"�7�1�� 2�<��g>���.��t�FgN�9M�B:@Ko�ٓ��|τ�5�ҏx�n��a����,� +b)*����}2/c�%A�<�N3˔7z�n�P�������m"F�(X�۞ӎM��G������K���5��Q�;Q��VŨ�,�	��
��������8^��[6}�q*��6f~;]�w���ul?�y��0�[����~��}1�Z<�^�wN�
L���fIaD\v�y9�T �YL�Ӈ~�Pgگ<�J�����Y     