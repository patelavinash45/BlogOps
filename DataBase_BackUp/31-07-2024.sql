PGDMP                      |            blogops    16.1    16.1 <    1           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    public          postgres    false    224   ��       )          0    181348 
   categories 
   TABLE DATA           n   COPY public.categories (id, name, created_by, created_date, updated_by, updated_date, is_deleted) FROM stdin;
    public          postgres    false    220   n�       .          0    189930    images 
   TABLE DATA           ]   COPY public.images (id, url, created_by, created_date, updated_by, updated_date) FROM stdin;
    public          postgres    false    225   n�       %          0    181320    roles 
   TABLE DATA           )   COPY public.roles (id, name) FROM stdin;
    public          postgres    false    216   ��       '          0    181336    users 
   TABLE DATA           �   COPY public.users (id, role_id, first_name, last_name, profile_name, email, password, updated_date, updated_by, created_date, created_by, status) FROM stdin;
    public          postgres    false    218   ��       :           0    0    blogs_categories_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.blogs_categories_id_seq', 46, true);
          public          postgres    false    223            ;           0    0    blogs_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.blogs_id_seq', 51, true);
          public          postgres    false    221            <           0    0    categories_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categories_id_seq', 22, true);
          public          postgres    false    219            =           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 2, true);
          public          postgres    false    215            >           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 12, true);
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
       public          postgres    false    218    218    4733            +      x���vG� ���Q�;.i �pe[�%�l��J���;�G'23 ��Ȅr!v�<���s�s�{ܧ�G���XȐ��.W�$�\"������$�ūdVD2��ވ硗�4T�xv�ҹx��U��T*.'I�8��������ao�'�Hf�{������`ޞ�T�S9��[)n=Q\�[_x�6�J܎��X���}/n��m$n��6���>�ۙ�����6���-�-<�F��^�'��v�"��ҋT�������X̓Bd�Lsq�!ysof��\���=�����T�J�Ie���+��h�R��#N�I<`���Ke��o~vdO��0�#f�jߤa�Ú�$�;�����@�S���R[���������?��ݮ<i��<��#L`尉PF���L���lO�YK��d*2�|���I �ev�!�*�9�%L�O ��55�~�2��.
�y�G�%ny	�q%�����3����E�n�(2��+���x��o��C�|�J�i����Lzt2��@ړ��(n�x@|+�\HO���G��OD�b�i �X�DLC�#��b:���e�i
���>�u��зdL F�~�+q��;l�[���%�I�]�K������w���Џ�L4I��y�a��0zT!"����qD�}���^,�b�a����&^�_E��}��qe/�~�y�Y5��X ���,)RM�7*��HX1�9U7Iz�@�E��U�#b����ŸU� �W���U�ʁ��k��u�d
Ȧ���5
c�m�e�ﾗr�VL�=1I�臽I�ϲG��c����>�@��G�~��=`W�X�?��"_�TE?��	~��"NFI%7{�_��"�)?�%�0�����c^���6)@�$1u�6^S��LXj��c��q��	N$��Oڞ�]�D0��4�E��?�mȠX#@�*UF�ްqHt!�HF��#�2UeV&ÁY�L�[�)�)\�>0#��D�cb_��t�@��@:+r�?^<�OQ�"��{{3r�_�q�pWwt0:h��s����B� �9�<�o��?;��yі�Q�
��YFp�1��5�Tt`J$����3'��)QH�5�&I���>�#^�p�[�a#.qss�a=�D��������l�����m>ݗ����m��Md:ێ���Zƀ���"#6h�U� W���B5�Ŝa�n��x��{�QƤu�H?M2���5�8�F��ڽ�x����Y{��Z���	B��p@�ސ%��5�e���2�nXPJ����;pDT���f	2���E1����_Hיv���ꩼv�8��s���'@�:��$OAư-|K�k�n���_���3��(LWiG����m�/`���i�:KO�W�4)��'�A(�]#�d5�Y�/����g����҈��2�b@�T}(B��!�,ݷa�� .�;��@�K�kF�?j�}e�{0�޿�������%��$�э��^ٞ*��u�T�E�[�[9�}'�m�w�ޠMS�a��>�a�J6c��2z�����U���I@�I����iĈ/�!(�Z**��.�Y��*/f�$�M���"�
;�Tsg o��6#��j:FFy������կ�BV��1��"d��� �UG�L�7 pq�OTP ��-T�щjf.eT��d�˹�z������+V�<`�gj�=.��	�/�=�a��ն�^{ZL�t*�v.�s����d��DK���8���QCd}_�k`�Q�_� 4�|�D���G�����=I�?�k6m��	ݎ�C���#�݀s��qb%�k������>o����K>E80Q��K�܅��Q�CF�ڂ/��� ,���p-��2I�áY}���7��ɗ�O��i��B-D]��Y�eIi3�a�p.^��IK��@U�,D{;�4�G2�ȆD�]'��E^���Mjx4,p���E��|�� '��%41Gz��S�`�1
[8� ��4�
<@ D�L!�~P?��X3hk�H�l�&�XՓS��kQ�.���%̗s�^W5/�p���@�B��k<F� ')Q8��7
�����_o6(��(q��-�^ R���_E�1-����6�a�v=@�������&5���&ҵ&=�}#6g_?�dC�0�2��[�V���qj�H�'>}�*FEL4�:�|%����b�@RJ�u�"k��@P�~ 漘�Y��8�B<yA� ^J��b�Y U&=��od��;P���d�`������YT!�0/سY��`�5���3�3	*�� /�
WYo��5n7�n�l+EE�nJi��r�"�<a,�����E����D#V���('�d6A_�/Qj��FM��1��p �"4S��O�DO����Q� Kqǋ3�| D�����kލO $by�zo�ׄ�� 8�8�L
8Ayɐi����@g�L�Kb@��ά�(70o���
2��_��y�:���'PX���1%� 6����Ixï��z���VhAp�<m	m�|�TN� o@[��AU�1R��¤�W8RPm���-]Z���1�uϜ���9�ҁ��bI)��,�9zL�ӌ����0 ��X�R���x�N���^Z��o޼27V1�;<��;���	>�R73�9��P��
�(؟O(kO� � e/$�T�s�ݳ^cN	�F���cp�Ql,k-)��dc�ɣ-��ˋ��=�e�����S��P���P��Y��w6Q`�/'v@���*p((c��nj�m9y.@U��$%}ԿRhr_e��~B9t�\@�����gH�  �xG�A`ͦ���L�"��G&J+=Pr�S��H}`�*e���y�br#��3�T;�!P�L�D���x,`h���12�ͤ1-'��� �F;jޖn�y��ɲ�B��(A-���g��(6PkC�60{+ɵ�7̲BT�A`f��Gu$����䩑Nݚ�7��Fx�L)��M2J�����^�,lMH~����W#�:��1m�!ʜH��h�X𤥴_��(5���域���Bh�^~�Ξ����1L���/$<��Zu��Ez�5A(�,�]�)���D1��|o䫌���?�Β8V�v��e�2������Q�܀��2��)�yZ�����~���r|}�<�c�G�S�q���U�}��ǆi�RjRĀ�����%Zyl)u�1�Ì�� �H�hQ:{Bf����HiV�H�4^=��}��fm��F	�ur��l'~/�$��D�"�̔�*�Ơ�EV�`З��,d}@�I8���L[��\��W�g� E�U������G��#@7��ht�6�#Et�-��P� �KG�[u�-�`�v�!�N!*�9DڮC����s���
�qg ��ҳI��6(�y+)r�<�R���S�e�# ��$a���Bq�8f܀p'�{�	�����S{�7�VD8�1l��r��y��^q�;)Xm<DiַG��I�Q��PN��'�0�Ǥ��,����G��l?V9�l�����o��!�f+�6;��i��D��@� ��FY_�:'RZ�!�W͋�s��&���@�F�|P��jJ��1���2�2Dg�&NK�"�1�BR��[0q�E��� J�ʻI_b�ӌ���BH�I����:F1sM����U�?���"�~�
 �o6�n9?8��aחΊ���O�UfZ	EZ�N]��ަ���Qv�1��ܜQ���DѬ��(Cj��	4d �����$%���g�%Z6�fE5P\:���pE����@��e��^*�~����T�~^-.����e�).z��!�'�hM���T��TꌢJaU��?`�P���q�6i�90��)���[�|q%F;��K
b�\������ IŜd4��b:<g���|�92Y��q�n��,,�`�w�����%V��Q���7��^��^|�[ow����;~��:ݓ~���ﺇ�����1sp�ͯ1&f���$F��#��    ��I
����_�.��ʀ�rF��� v��t
��|ͨ4o�����[�?�����[=ꎚ�妽벧�9���h��S���1�bNzK�8�[��$1y	Ŷ(~���Y�F=^�$2��$��I�|K��`O�&q���Vr�S�^�0�f-����v�r���
;N�p1��i���
ŚNMȐ���1�H&�y��i�� �����Z�.fXa�VQ�-LxI4��D@����L����r���d���`UJ��ru���y����
�����Xx9 �B��h
�1&+#{4��2�K'�M)ˋ����������=�q �{���"���DWP�����P!��ӑ�M2
���$n۳��sEN��Iм�%�$�]�9+��S}Q���o���u��wt���r�_g�z���NU���Q%W���0z��
)LxjXM3�]Z�y�����a���o6��eEO0[��0��E!��#�	�ÿWB��DfS�7W3���V����Ba��D ���x
�y�K�8�Y*�g�o~�V�$�UN; �J�Bю�`DAx:��R�~��I�>k���.����|��v;O���4��_���GX��8I�@���ي��Ѩy��g����r���i�h`fb�*�)����VPt�{2E�ޫ����t��Rf!0.����߹2Ƞ��U3�J5rr��dqm�GI>�kW�AO��3 �\6=J"�3�"�@;�)�^��GZ���Ro��b�<Z�Z{�ɪ�iBwo���O��S���g��pե[��������"���J�A�
��
/
}#"�\�k�Zq]摺vF������֭-�56X�P�~s�k.�z
��w���G�r�kML�w�k0<X�Om��=�����z� 7b���>��n?��/�o{��汽��dW�<�N�ԩs����糳��\x�!@֬�Z�f�9�#��w4�1�m����tC���{��mEG����RA_�O�j>x������%�O��2�{*�z�f�����\�YJ����E���_�tE��{�	��� �)A�͒8S��\�Ev��u٫�b�)`rݞ~�wK��mn���_��%X;� "odh0dq�o1��0o݉�+�����HU^��ٯ{�mq����?�z�[��ݖF��$ѝL��TwS����T��Ө�E0�4���ƍ�����K�o��QE��??�稠�T��蓦gr��	���p�ｍ^����x��]UD����a�?i��ɸ�1�#5���љq@M���"*ϛ�\1A,S���F?��AGD�
��1]FE�|���Z�+anW3��*;����1��5Kg��3R���}	I�Ƙ󊋀�f�a5�������=�BV���Qv��tN�ΐ�r(����d:�JI��1-Z:�ApVv*tt������,�C�t��9V�f�5�.~Q��Q��z>��8�n�	�Q��BΖo�|]������a�2�VP�l�L4se���y�6t�넂�<�oq8j`���ߦl���!P��y;�d݃�N9��p�r	v;��Τ��p����罚��H�+:+�b��r��y��q�؋��l�h����I��Vw��8?�;�&�fJ+W��=?�0V̧����˫u�B5I���\�dutm�uZ����q�Q�Bx=��;h޶�$�#�Q��Gv[-
�H����`S�J1�-����7�ZR�� ����,n�d�"�X]+�=v�����~�ͷC��;8�i�QN��Q�����G��Q��hG������b^���vO����>Z@��w0�C��=^�ͬ���'���rﭣ�^0l:,��8�ߢ�v�h���Ջ���܊�<O�T,sl.7O����.��=��k�TGݯ��H�ٝ���te[!}1V��ι��N]���M4 6`'�c�<��j����6��zϨ�զf�<>j^��7d.�"�j'�0ӁD샤����(����M�(���J���<��x*�����[abǼ3�D��:�*��q�����TR���K����������Ω�o�L~��H����`mcFR������=o�"����C�k�j����d`����!i�_Uji�%�@M���)���z6���S߶����Uk԰�wN�Lj�j���<�"��`���ڨ��hh���5�w�`��0��U5�z�M|�լ��l8�Od־|�l�)�!V��h�-�z��w)/�kq����J���l��}��vÃ����l׹�W+�=��*��`�X�PE
���nco�m{���1�SqAw�x��џ�I�8q�T^Q�\?�}J0"W2b��@g2H˰6Cip�5�u�sr#�DQ�� �������,�Y�7�:�^�l׬�C	�J�5ƒ�Yr�\�X��^e����sx���%�ye�0���Fs*�7��d��S��5CaAV�4Pɭ���~n2�2�Y�'��j����,��4 @�Fk�AҨ
�049���@Aa�i��;�HӋf*As��|��ҩsvf��$2{��?���`GN���Γ`q~ %�C��U;���s�Fi��`y�|^�4�����pf�?���-&�)V8a�NOv�-�[x�����~:�8�b�E=�C��q
G��p��qn=��ǝ����<7[	̀LY��g!`ƅ5<U�����i�Q:ʖi�MM�x�1���� ���a����W��O�������Ha?�0��%x�f�p�M��������QF$o���l,����q����7�\7x�u�@�4�Z{�ɴ�0+⼠Hc�-���,� ��X3mj��b߽(�(�AKȈ����-dį����'aLs5w���.�<��g�'�ǜWkp[���jyb?�D�QD�n^�K�w����~u���Pt��B"m9�6ёZۣ/���nV'���yJ���A����V��W�)�"�ũJ2�>{�i�����6\hG���������DM�R��U��p{���8&���Bd����Cٛ�ϋ�$wfC怣�)q�<�쵥 z.\L�{�[9�Ԯ��4�@�nt�L���n�����B���38P�ӌ7��f�`��<0p}p}� }�P����I�y�ϯ�؊[F>�'�����dh����	�����e8�����ޅ�k���^(�ex��5��	AG=��+�����mcSPήѐfY�ya��W�����z�l���c��8gd_��Vr��:SM����+vNK���i��{�N��۰�V��I�����'�"��tQJd�t�^J88^�KEM���0�Oi:E��OB�
�s'Dkh5��v��N��5g_"�H�5ܫXj�+�xjvJ��Ç�kMi�p��ڦ)���=l^��9sy�I�*�=�.h�e��[-�*oz�~����SƇ���C�6=�/�@�����u�`9n����=�&�)��5v�&7�s"v�k��@X8��i��ذ7Ǝ��]��*�*~	Kk_Z�)}t':ˡ߼���3��qy*?>��ǥ�I��Y��P��h���S��Y���Қ/��H��*���)�X�9bS��.�UEfZc@�8� ��\���0Vj��Pؓ�|:�c�6�{��o�2�ִ{���Pf��SX�4����rfyl�^�[09�qm*�q��(����I2�� �^���c�t�	x���q ;��BN�O�s(5�#v!	���e���یz�q�f`6EJ�R����+xړBg?���s7^jU��KƜ͈m���G�3Z�[����:z~K��r�J�4�d���}	z6��B��^�5��{�w�,)Y���\�L9,]���c#���E���{���t�� ϐ�3�$X��iL��6(h�S0�ڽR�<�hP�K��Jl�i��Wy�����H�Sǌ��t7�`�'�%S5����ĩ�%���O���!y��u���p�����V3%]`b�w&z�Ɓ�&�(ʑ�E�Z&Y���Ju���P�hW�#W�,�r�I��e��N�����'��hI24+�ày�+)x2+�    ��J��!&*��p�A�8,�fRj�����VƘ<2��\�el��8��u�+3������2O���T�R�ܶ�*���˟�>l��@�yq�/._�j�YA�>�7a����}=��vN*��t��״*����V�^	��s(,�ܳ$�V�%�
|�U�r�N�
�a��l�T�Y���f�`oh�3^G�
"�U��/�
�n#30��I׉�S�Ο�Ec�Tb�B��N�Dz��
��VE��T�k�V������n#�խv�*ϙs�I�5���Qw{����_2�P�On ��`��]t��31K�9M�UV&�������W�"�q6c�G Z�� ���Q�q��L���R�e��.lN��#g&09^f�hΓɏx�|8�Q�4��ReA˧�$�~2�Cb�p_�����f�a�eGEJ�3�i��R��5z�D�[��y��
nꜤ���@6/�sE�ړ��8���������ޔ��d��m��l���sMx�Z	z_���5Af`z9!����� �E�ՠG)����u�)���q��ɑ���Ó��i���A�����8T���������ag�ٍ۞�Η`S���r�/I�?y�t�N������>f�7��oA=�F�1��D/g���N�d���%���b���/'�.�z�N=����>�ͱ ��oq�Y��C��6��G� �<�"��=W���sf�96[s1_(o::9ھ��Q$.p�'�q �%����rBh³�z�c7��te�Y�xiYN�cq)��4�0nѬ�iY�oUr�)��Z/��Q��Č�,=<E��d�ˆ�̈́?�WTqf4~� �%��A�0%* ��,���B��sF/�>zܫ�A �_��=����O�(��cN�Ҁ�Q<G9�PC ��k�(WS2���w�3��~	G�}B��g]kq�X���tR6z�A[g���B���]�@�3�)�c�Q���0_� ]�´ �8�&`~b�^[Z�8�n��N,!�B���&%5 %��&g���)���j�O����L���Ã����o� ƛIIɦ��gO�lp����D��ϒzya�{��L\�9�0����Ít�¹x��8��q͜c���~ߦ�n��|�������NF�rz�H�./�7���N�p6�4�[��h{K	�?�5Ow��z4L.����c��*��d�z�S
߳iJ#��(� ~�*�Z(�ti��01j��U$s��0*N�}����^�t'�;ǆ6��Pr�m�V��|L�$uX�u��u�ӏEӊ�k� �ez��� 2]t����c���t���`����$f&����X7�4q��-� X'}���{�fj>K�<�,�T5MD��pv�����&##��T
�O�8)�/!�|���zo5��<�������C`���Cp?�j���v#��莈�L9�)�Rk���D�Y
�+�����;�tc�D�C��w�k��9�	�<
mz����:���T���;�/�V'�"g�A����z`�N�������'��I�7�Zp�e��A�q]H��d��[ݗ5v�::��ӱ��l���5�W p��FR��$�nE?�D�~��0S����%/�Ԓ�,���^�}V�����T�0�m�_�C���ա����O�����-^k|A��PfV�^?�C�]F�e�<�?k�x���FYv?̔�2}�<�O�.t��iJ�.�>[�cK�ORd�Ѽ��`�WM�xyF�u	��{�|�V2���p|8
��zx^W�J�*t�>|�z�)�;��sx��dqf��x�C�Z��k��瓸�)׷�>��d6�N_<���?���\��m[V�2P�F�s�%l�����A�<�i��<���@q�7��]�g5�_g�Y�Sf+k���Qt�k�Ø�Ñ����BO��5��eJaN8{�����5��O����(ɗ���yCHN1u�,p�KW��rS-��pU��h�Y��^b���?7#�eX�4�t����t��ԧ��tLAv��@,o3C���
�T�=6��~_M��_.[H��	����_`E0a󴨗�N�ګ�jo'��[ʇ�.�rM�Z���O~�O��zU�K%�x���P�>4�=�[Fa~����5��]���[���r�m�Xo�r�v#�_6W�v����Igd�%�ed����X�Z��Ӻ)&G�i�󚳕]w���N˼j�A�i�]����{�*E]?t�I���&��6e�8B!B�k_&��h�P�Ñl3�F��7s�4)�y�X��v'�H���E�ܑ� �Q*3V>F�ZB���/`0�|
� �`��r�L*��H�D�AY4���XU;cp����6�]"_y�m!B�h�h��|V!Z�埗�\�'��{{	�@fy`���x�Y?�9	�P��n9.�kc:�,RX`�3�L�ԍ�
�A/�g+�ǐ�(q��Rj��Jjf��	i�_FcL7�^%��Cvo��E�K�/a���� �,�-�0U��/��.�,̱a)���L�)z
㳣��i�q������xC��I�u2r�Q��G�!>L�PA->4qf�sU.%��lo�S�bAJ��˓���'xd�r+��"��<� ��b�+��[@�$R?�e
�/^U|��^�����x���"�.�MF%�&㒋x��'��Jş2��6�
N�D�$Y�d/�F�$=� F���`�8�u� 6�N�d����͠�P~��Yl��y��>�Dl�r,��gjQ��/�_<4L+&1�![�e�d�u�`P�+�LnM�Z��#� ���8j���d���>����},���_w;�a������&�_�w/����6�cټ���e6�m�Z�B�Q�8���:�oT���Yp�"YG�����G�RTw������s}�������;����X�����o�B��j|�2L��%�^_}N'� �T�	T��5��U?�\e�� ��e�P5��`�������o_~NO�.��U��`� # ̹"�"7q��RKa�²P�+�ٛ?����|q��Rnf���˺l%ܠ���][P���K�� �5�����d��t$�
O�N������s���Jە!�(Q���A�'�D����<5�L�t47��n3��+BZe<B��\6y��^���7ϒy���!i[���e�Îذ��P6c^̶y�=9���d��_���If0�M��	a�D�si�VIZ�,��1e�a�U)�ym�[�2m�T�>��ɖ�s�*PI��j�ݙGq���s��,J���(��ɺ=�v�?:�~&ؗ��0�j������q��8U�~� +�hG��MK�X�u*�}�t��{�X!���Z��5����r�Ժ.>���v %F'�i%|d��S��O�(�j�C5FKEi5�Ά�&��Q�s?v�i������B��×����8$��]e��@�ᾠ5z'�M,5O�U�\m�R�W�T���ڭ^Z�:��4��RS�4Q�ONBԠ.�3t&�^�����a~/Eo�[�]?��_�s�asҎ�K����ڲ}���P�
���<���xx����cٔ]�q8u��Ҝ����S�<+5�z�T���R�s����U<~o�\w�Q���(��>���~�殺�����"��Yi���9~
o.h8�6M���h������C3"P#	�]�r������o.���޸�1Z~-U}��7I�=CB;vq�B����Ӌgb�?O�/_=?�����g�/�_���^?�/Ξ].������g�P1+&�j�Ɲ����b
J���N`��k�1�5�K�k��m�h��e��g_��T�8�Zs6�{p�����V�T�E�i9��'���餲BX<���]�=V�$1g�f�;�����<��O��!��1 F��n�EWa<�0��*���G�� ����%��ȇ��a����xT*�#1�O2`_`�������)��8y���<w~j�D{v��QC����R�Q8�,֠w�Ljt|�y�I�9������i9�蓂]�®    �oI����Y^����Մ���b7��mO靋a
�d!%��^�ṃ��h	̽x��HwC	t��3�6}�'1S���ֽ��շ
RQ_Yo���l�h:��_�|�������Y�n��-.t���G�5?�����T�dm��m�pP�6x��(C��~y��w�O��s�`E����׺��gg�����o�Ѱin��*�B�7���E¥�	�ISi��&$�81'�>�(O�ɸ��CK,.�I(�zؠ���A�9/S2��mv4l��t�%y�Ĭ��]�j���Rrf׮�Z��%��Rv�!bZrUp�BhcΝl$46u5�.�L�ŋ�����+ι*[�a�dw�k�[�{w�͛��*�%�Bg��˯�mQ�?|���n	P
v�nJ ���3��������Q���P�n�p?�f�
�zV��4D�9��O�	UsΜ -��YqP-aJ�茰W����+-��i�76�p���F�H�-d������Q�H4�J�8c
��6]�0#%/�	���C�˾ưVN'pRo�uP�ێ�J�ౚDZG��䦴l���-�*kK	<���37�T�m�V���s�����SG�����T�^�<����mƉR[����5��\MP�ooєޙ�ۺ�m�	�F-��f�p��;���p� �����6����`�8;��~(ըp�i�O��_�^�ݲD� Y���z��w�."�:D�d���2�g���-�
`� 55 �T��P����|"�e_����g��N�\�ILZ]�?��E�(2���R��s��K�<:�V��:T!����k3.�h���B�I�5f�~�I�;������x�ĩ����T��bL*��K/�}���;�������ˠ��\����Ԗ��Gǣ��l�u�zw��ig�9��+BQ�^�9���}PE�`�mh��*˾u��S;d�����3�j��*��}����8O���|���w_����+�H�p�ݏ�6ʿ����q�(�V�D�.m��:��(q_QD�Z{�̄�a���MBKW��Hb>�m��L�ԟl���=��1i�,)�|�����N��&h,��a���`齭�9U�$�[������F�W}��}�RVG��۾���h�3��:�\��;-�FK �)�������T�'�Ҧ��A�(*�M��P�M��>����MPeCF��#�3���G;݀l���Ƭ�vKc!Cu���ј*Nht�9m|����Wլe��$*؏\+�Y�l�5�����܋o�4�o�)Ӈ-��R�t�F���|߉:jg|{�yv�3g����sq���:w�!-��ʋY9����'v�g�{j�sN��sc"��=�/%������R3��ݘ&�ֈ��k�톧EVO���?������?Mǉ8{�¡p2ܾ��9��k��l��V_	��3h������x�+S�Th��Gt���uG�^SJq6w�w������'V�8�Y۸ҍEa�h������U��?>��-w �z��~� |��9�L�����h�p��P���/t����#r�(}������)��:5-/&)�
�A�(8�S*G ��zo�֝��E����������vE�خԘ:�*�}&hS�X\����7�O�e��풚�en�ッ��U�Ɇj$U�}]9١�T��N����Kؚ����e|ݛ�(h�%���-=�ꌓ�37k is�G%��V�rq���Bq߂ŉpX�b�E6��̜߹VevX#�ʿF(>O��f�&�98!��D�0D�Hq�t��}�����5l���o��A3��I?h�.��#�Z�i�����į�V�}�Y�͠X��Z6�+��X��Md6)����������-�ߠ6:tyS�3[_��b�"6�![{|�F#������Pz������qW5S��-���B��e(b���,�3��U��u�y��fѯ�6���1M|�F4 L��6������n�B�	�Ug����+ �>�P�����jp�- �zK�
N/I�oU��d��S�*󒭛�>=����7�x喇$��~S pdK�G�A����e�ݪ��7hJ��-"�`��D��t�ϗ�W�_�r�g�8�ZV���)3F˺�ʜ-�#�ر���w��:�]��l��n�v<�T��O)r?���iV�t�V�%Z���
��h��^_�/��R4҅*�&��$����0�N�V�6�^Sܾ�6�=�s�Om,r�j4���s�9��)��c�x�9���������H��S�Ql��jJ�nu`#��ǔ�G`c�����F�лך���ݚ��w���!���2eTF�	�K��T��p��g����CZLfzXLˍ�o0�:�n� I��*�$]%��q�A>C�$)�W����t����O2��B�7���:�f[Tq�ns��X����p�Z�|���.	�In���џ<'f�4q�7��(�b�x3�qZD��]����G~wU�A�{���M�Σ���m��L�2DJ=Z���<#�z�tm��Mƺ
H��XQ �%B��P�{�A�N����̚V�a��.�����ܯU�^V�ƽ�;g��-��������_@��>��$����hE�n%�bM����Dn����3_DnU��e���L�S__�>���!*G�Ll��aS��AG��X��4�p������n{M�Udݏ��xq�"���0���f�c��AtS�	y����x�t��]���j{L*���i�q�n�����Hۅ�"~Ż;�٣�����_������o��8�n�Ue�����%�l�םn���$�>����ǐ�:r�Q��8�劲�5�)�S��y�xt�U�0���:�a���U�O�Ď�'��|M��_����/A� {��z���0�d��կE͋oUq�N&�ބ&nJ��u�4��:��f��7<p���0�.�R�ի�ժhU��Wm���N`�v�˧3΃�AC�}��5�� a��STw`R~����M��<4��Z������v��zG�'ep_+�sQ�~��Y�Yh��>�2��p݅�{���}9O����H��7Tm/�o��4��Z%4$�<NfTB�e�����!���U��Ld���}�����N�%WQ��2����2��fͻ�k-������(6/����ԩ�\����cV+�A���=�S�u���w���vU��ITL�Y$��,��g�ZD�;�絝�",��i��[�v���>�|�����n���~o����8W��`"�YK�,�/y��K�s��ۘ�o���ɤ�4]O�YW�S\����=�ļ����H5s�w�쭮'n�d4R�[�% d.��M�V���B��nO=\.��Ƹ�W�LB vV�PQ�^��	u������(�R����.<o���ߜ�^��.�ғH;���ξs:�V�ֲ+ع[�lz�R564%�fAŸix�w�P0*�u';V�yb��0���kkY��ЎA#�
��'J��_5:)u�{)����2[d�� 3��~��+Y-�=4�#��f��v7����[�[٩q�e�2Ǆ��Ɨ�p�#�]�4��WQ}�2a��bFm^&ܕ'��X��O>Q=�ty�NS�QbCH(� ҅ס�7��%�O�c^�ܠ*"��p���KZs�]���.ڌ$��+�V�����P�E�Rj#i��uY���^a�&�.Wz�i��רGV�ʾj�[â^/�7f��jڭ���S���*+'����'�W]Jˊx�����E�='1�Y�I�����찂���;i�[k_!oҤ�x4��ռ��rے(-=H;)�����g���#"�Վ���nQmEF�2Q�p�S�ى?�h��)�[ z*����õ�w?���훃ܡ+�������ði.�c�̕�t�#�v�^�6�4Hư�M<���h�E2������5{?���x��hXr,�m��;*;]k$�l���]���Y��8L���_m�f�m6m$�:�;y2����i$��d�f���3���ԏN����`�t�l�7��tˀ��F��^�Z��-�׉[[s�{z�� CΟ�0    ��b�o?%Pu�c��m(��i<sՃo��J)���=v.e?��y�����b$'�;��F@'�[�Iwk_w_��t�m+��`{'�n8�FPf��Z��y�<Vi ��$���E��ج%
l�+���˧6�Js��ƨ���b��m����D�]�_��U-?�;���̿���]%�:��Dr�(���׭C���z>Y�m��~�	�O7Y�q���lzvj�N��7��f ;����I2݃��&���>���(�����D�����+JNzMI�tLEI%ĸC�-�+��k�l�{��>�`	���*��8(r�I�^H�[��=�
�픡V����^��8�b�Z��FRGy�3-8�v#h�=Cg�im�)�r�t�B����_������O�������� ���~)?f���C��&zu�侬�䬦���h�L1sG�Ԇ�������S�e<I��'r��]Sj��f8�U��y��K��dR��	څ�ߜ
~^��ja�)ez�rRO��TQ�C��6�t�G-Sک���VOFp	֖`�;�&' �tR���I6���dK���B$���1�;7ۀ��Y:��0_2<g��ԲG�NS�{�=��&��$�~v�E�;�Y�pb3������dj�	yJŜ����8�s=��6dNG�%It�%i8S�������x�(�t!��|5~R���ytM����`�A�:v�8�:{�T<�-�_��NO�\���/�~�B���*���f'
���`s�5�:�/IA���+���.[�AL�����-J?/0Uڼ$O��iT�Wi.��92��ʡ�,���DV`Ʈ���GE)��0�OBG�I8��{vp�i�qr8%q�=� Vm159��M�a�M@�T�uO]{0r�sЬ=�*�F��敫>O�+b�	!ͨ�,�E��>�PԾ�	.�@R ?�Éy�V���#Χ���z��3��P���#}汾dA�U�*��#[R /�T� ��q}��$�r�O�$Jơb+�¾5҃�;e�o�P:	�V�L`(y"J:ϔc��K��[N(��% DɌ��,�(��r��ܪ!�Ax��'�0���H>��/@�z��=�&��a/SxR�=�h�n�3��}�"�[|t��@��<�"`{%���a��d|Ř��+-�EN�M��<��X@>Рf
�����"�)%�;7��ȦM�:�T������w?2�0�� ���^Z�˭��{b��:3���4wDS�n���$O۷2�Mv����R?��@���Ay�]	�:2)�>��Q�E;�r���;��T�����j��w�k ��׿��oa(6�otbU)������	��*��V��T�l�������[����|Э�ڷ3�6���,B��wE��z�� =(Vo��xU��eG�T|s:cY��?������������?��:��pp4����A�^0�^>xt���z����K��Ó#}��o���F&@�u�瑜J1���A��	�R��������O�0BIn�7����ކu5�*�8CĚ��sݲO�h]�7h� ����/X�����+?e����8-�U�Rُ��a�v�\��XE�LE���@6������T�$&SӽLI^Juu3��Ws��xI*a�55�lZ֩N@e��1 �c�]r�}0[,��Ńz��T�H�ʚ&G�}���n�p��ynK�@Qǂ/[)8)���� ���!�vH�`jc����C*:��$��
�V��E;MAͦ�2��P'p��$�+|Y-�WNFX7X3���x�����+�n�j���_��������Ё���,��u]�3�棩'����I��*n����LI%<9���l�����Pf01�7��l�c�� ���7�G��q^V-m?{���O�~%'�~l&��XWA�xK���cX0au6�ĝ����*�B1N��w�C#����bD%�E��!�e[�����b��NX��]��JwQ�Q�h�s��m�l� p�FX��5b_���L��?�D�0[�p���p�?l�k�u3�h�#W��������<�@i�o���?]D��g�Q�3d�Ōo��>0Y��.a�0B�|$�up��* ��#���z9�m�x���-F*˸��
[�[d�t�ABr�pZ��Z��(*�U��74+2%���zP~�H��]DSKb-t��X"g_
�x�@�\4l��Hg)A�
W�,Kܺvt��Y q+��׆/
^2�E�zTe�������2�%�c#���٭�+H���B��C��4hO���>�
6~Ń��@���Y���ר�`e)��A���}G4�#|~�t���`��~Ml�'.����+2�A����
�A��ă��1)�}�䧆	�	��9Tɿ8M��B�؞ ��؅˾�(��H�V3a��>!x�5Hnb�Fp�^�׌}@�ȏ9Y=���6��(�C��ً�J�M"����ǒ a�z��Hb�j���I�I<�U�H��=�܃;0s$�1`T��xt�>�C���~�`B��.2�=U٤��Ԗ�w������'%�f
iUnML�e�rî�mI�ȼ��S�ZXm6������������m�Ơ�{I���������k�k�ٴT��-���Y�}X�����s��eB\��$D�D�9�\�d�$"	'���3�"�G��m{�:���N��s�i�َt��t�#y��&��K,�;�#��ht��Ȓ%���I�p���_�YX8ߪ�[!��6�!����
��u����*k���P$���u΀۫��RW�7��̩�	���:� ,� )J��>�DWO�����Mhz'�5-+~ت���$���#����Zج4j�*	���)ނ @PІ����$H~�DY=^i%!G��7�e;��y<�n�c)n辖�KI6�a��4�*�Uﶢ��A�gE��t�E�-ӴI&}]�b{5J���u,��a����m�d�q��RU�����	hC]�]"ћS��;�s��47I���\9�o�'���L�>� I���J�M�mvSa����(0Op?�;Oh�z?��n�m�ۯ:7�٬_���qU�dTve��T�}(S`7��H�<�K����,�ӯ�A��w���)��=�U��`0�߯�!
T\�V��GS�ݱP��T|*~�h�j�S;�^��[�("Sj�wcE��堄��O��tc,72�����!挨W�fzqJ��0b&/�O�w@�m�v-p38�H�"��5�����.k@_Z?F��0�{Lcn�P�;p&�N%������#��(���ټEPm�;,פ�G�BK���d��S/�[�����������9S.L�W)�F!�u�>H�v�즀�W(�[I���2�R mb�]�����rY�;OAM��A\N4{�Q��DX4"@�%�CI^ v|`e��g�n(��B}̫ F�L@��j:�(I�:���f��6jM���d���Su2q����^���o�`����6�!`&����S$�32X��ȴ���^r�{�K�ؙ�ڦ&=.Am�|ZX�ʈ��і)ժ U�8��Hh]�#`��BޏP���ߊyY���)��=5��Uհ䒬�Qp*�����\R�j���yIZO�(a/�B\���y���6�yRh*������5��I"/����gq�qk��CV�����;AA����?c̨�Q"��Ÿc��i������(���ɨh3��_����<�Pa��pQ ��"%��4�Ta�C��$�w�1D#�o��')���'�X���'�+T����>׶�r�y�4�x�p:�y0�à�q���8Ĕ�[�-B?ª�2��CQr�SQ�L��S8��Q)"�l�O����=ufs�j����Z F%:����qN�W_�0���xW0�,h�.�� �l�"ex%�1>8��yby�4��@�洑�F������>i��i;�mߋo=ZizgW�����t��� ̍���    �;$�`�t��q���V1�O�$V�D��n`�ɜ�v#[J0�#����&�x(.`D&���΂��|�D�u�DE��y�1��1zW�����]�D_~۩\�?���^U�nO���	�:}����wW������{ReI��'զa#��&�dZ�������o�
���]�ms�{?��܏!��}���
80�,Q����Y�f��*n���-�TZ�w=v�����C{];۪������hM˓���^���/l���R������"L�F��)p9F,-�u���W� i�!pJB�M.�dTu�S{!e`s��/o��&_���3B��0��zD�bⅺ��+ٷq�k�/�n��mz��չ\��o���s�G	��۰�6�ٿ���p�>���+�Rz.m%���!����+�hn���vw5�uA���/,�w�;�<d��ӎ�F�@PY����q�N�c��}�\	���Ma8�y]��߽�n�8�me��r).c�&x�X��8�~�M��[�q\���Ȕ���A�[@��y��HTA5&q�>�������2�.��+�Ud�ω<񲫶����es�ͣe�m�'�-	ƎX&��}b�;�Z�	�����" �H8��*�M2EU��y&�ػ-$�?��N9l���	j�qP8����>G��v������³~�5U��#�"=9���W����������*RsI�䰬"=���cי8}{�H�%��qT���п"�`?{���dJHdǷ��YDs���I�o4Eڮ�b\˫�u&�,ɩ{ep�ӿ��4~ԍL�M�o�}y:��p�[�Kֹ2� �������3傎�V� 9^�Ď%Μ�g�}��	�=ӱ4�u�&R���~�C�!�eg]e6����bP>M�"�k�6�DX�h�Υ�|Xo#�SM�Ca3;�It�߭}-�&VE�P�ܰYr�R�v���Ҽ���V<�]G��aPyDe~�[=4[���ؙ�r��1�"	u�C]��&G�kQ?;���)�ea�2%��uJ� eĩcX��q>�+v1��rc'	i�'�%TuH]��!�;��C�|����m^0Ä����'�N�AAbR9��%R�N�?��h:RA�)'�O��$����j��У�
j����[��TA=`j��������l��~f.|@���\�X[���!4��c��J���V_��9mj�h��h��~F�����jl�V�TٹN����Xn��7�2r�y�ou!�Ο���۫�_$kp���r왍1���où�˓�m;�%	����;�x���ȧ�|	d����_��O���S���~���*���T�8/oE��@��;�t�Ã��A�{r����R
�.���e26MӮ���ə��.�^�s#ܨ����Zj�(���0��	���#sS�3N� "��%D���b�|�U�H��3�'��L&�u?��� �p�u��>�8N��CSi7pOT`b���l�C9�d��8�K9'���J9����.Z���/K�<��M)�X���^U�����~���]�&K�B���\��J-I�m(����4�Ohue_c-�LS9G���Ę��稕;&��ph���x<3�ڄ2)��+���׭g��� �I���iT[f���́�;��LI��!�f	�u���D7�i�ީ����L�!ϻ���Mw$�D�ם���ɒ��]<p���u����&����k�YL8�sk�����!�j�5m��6S��ն��t�,I���XT�<�K1��T� ���OM1uA�'&��i��v��2��J\��%�Gb�di�u\��t�q7S�Lp�dj[��I��S%�?�Y��f�	���iW����1����s�v �.al-C��(��S��������b�	%%i ��Ͳ)���3>��L���3�1���;���h��U���)0��������(f��m���FPMG%��ؕ{��]��dQٮڶ"u^:�ޖ�{E�8�>��$�#2Z�빑�[���8�����Jj8S�t|��4��5v��}���2��]5���^@5�i�WQ�W��� *�GQ�6�f��m�^r�;<s-�h��T���T�9����4��f䚻G�T�ZQNLx�b8�I]�hY�ҿ��<Wqr&�nW��8�AoDZa02��9�S�l��k�Z{q�)�5����:a��`�Ԫ�lLsgr4��p)|a��E;��\�6�$���W}�2�H�\��.]�3j3����"��DTQ�'u�#�>���@jWr�S����>P6Z|�g�y��bV�5���7]�q�A<�K���z�/���=7�;+���Kt�G��Zrz�B�ԅ��c�ZǨ*�%�2~�QvB ���D�L(\�5 ��i�-r��Z���!�GY#�1�%���[�Vc)m@;|���ry'� a�҉�2���w�\N�@�<�=ɵ�d���3W��G	��!��}�Q#�w��YXO&\?h��ZfV������b���a��vd�+cͤQ��"_��mfp�ú��o�u�@w�֒-i�C�:�Ϣ�aFF�fXjd�jO�t�u$ �"�6.7�*G��<7;�ũ0��%usO9�6�؟�י���*7
?!��Kq#���1�*�!Iˇn��H��kڻ��>�2�68��V����0��I\j�����!��z�k��8�X�m�l�I�x���1I{�$�.�K"�4�th�ېs�_�Sm]�D��yQ�_٧�b{�6�j�/7:F��iq��J*Ҹ�'&_7��G鈥���#x#�x���,�`�Q�;*u��5�'�,������3��녭k��d#�0$vRa ؃WU��,��^�c ̵k�nG����.!qmaX:3�/w���N����~+ϯK��"���9:q�X���^�\���K������2c�_9�鷋� �0e�W>�kzT5�W��\<�DX�te�򻹲�ou��k7�oǨ�k<��xwJ5/{�q��ٯ�"�[RԏL�Y��t"i[9���n��'p�O�7���;j0e�j�i�I��>Η�����K�0L]ܛ;�l-��vr���w�5���r�=}qY�Tk��M�#6��T۫C��*�W͵�3M���j��6�GJNH������]��/G͆�s��؟/����d�K&=Eķ-	�@���b��4 �4P9>���d�aW*t��qZF�z��e$���+}�u�2��Ք��r�z�/�Wt������{�sY�Zj:�o���|ƭ�G En etz��qN
/k��P�JlB�h N��q�h�s��x�F�E�<�z�Iݳ�z��u����y��좜�h��Hx�o����: �TZNu@�zD)�1Kj�������h�>|5�Fv�p���Q˙L��8��~U�T0<�M�;u�Y-�>af��$���lFyZ<��h7�?�?�E�;VN��Ϊ��ΝD�4�A�i1����آ~��'�& ���u���2�en�&j��q`{�J���@�.���u)�vD������p�E��?'����������uf��6y�~ݻVw"�i�U�x�ꀩ�)��,Ц*� "̎��FZ0:j����gLN�z�;9i���B]�� ���Z��_p�(�,S�+b��(��IK�)��-q1�����k�� eƩ���^����m��%G�]�kx�'�I	c�^T>����AÓ�^$�z��Û�K���2��\�t�i��	�2�F�-�{=f���,�@�2 �i�5s}��5*�\$��y�4�$�� �2��YWs�3ㄕ�j5�A��.��	ʭ�(coʖ&Ox��
g�9x�,bӮ�'m�\ �`���)�\��J��ɑl��WS^��h��f��n}Ӭ��St@6�,�*�t��k��p��=�6�I1s�h�HՎ0-�x�ew��z���O�y8�i!��J��7���AC������B�]t:�^�7�qF�ּ:D����\�+��_�g<7ϸ̋ LZN���W%u�Fy�J���nj-PBe;�)���+?̬ks[���P,l�� �  �;聎�ɱS�?�u4*ɞ,�9a%��5�����	��i�Х���Rm�iI�&3֋����?]&S*��S�Jn����%ؘ�Kѿ��/R�X�kR��{Y_rs�sF>2F`�KӠ�>a��	�Q���L��C.Vֳ�nLv���2Ff1v�7�ŔR��ud��P�۪�1N�N����c�8IxI�[(*	��9`T�^�y��]��[��*���L��3Z�D/�VFr
�L�Q8�jd��U�ª@�`Gb���a����&p�}U���,�N̢����t�c��椚��TL���F�&�@��2t:}/H�a\��.υ6�̽�=����@�@�]�Q�)%t2XB��Zasy�S8�k<��T����5�8���H�}Fg�7����b Tv��i�6:_J!+���Ah�=����<S�J'a���fb?dh'��;L�gBY�@S$����G����~��#%jFG��a=����P�5��Н�5:�m�t�T�ݦ����#�����+"{�&��@�dcؤK7�����ĩ����v:�g$�����>j�U�k��K���ټ��j��'�N���q�Ď�T %�5?��M�B0d�8u����:�'o�I/�,�e�y�~�aAz�q�]V����v��K�Ќ  �0"N�hM؅��̮7�V��Tt��fp������=?7=���>_+>2(�o(��nY��r�;���o��g�ɔm���Wm��M�-��mXS���)�H�#�C�:��~%I���_9�O7�;n���l�{5��ʽ�?�9�-�����j����6�GG��a���`ek��N�;<>Z�چ.tMk�����9.�������Sqn2��mu����V���~�����,����c{'�bY,�``;k�⋜W���b'�8ؾ	�#N7��L�#�[Q�ś��!E�eF�G�f{�*[�wp/>�ASN�J�(v9�۬C�d�0��y̘&��E{��"��(�[7:�}�e��k��L��-l܏VR&X����-�kL�(5��7���*�W��(�;Պ���4����l�x��a��>�z/�l�Pg���Ư%h�Ҭ�i��T��O��+&�J J�Ho@���`��bμ��|����	��rҔ]*	�1+FSs�!��Š�b�-L��DO��U��S-c2Yj�ϟt��K,/��
<���j��4T�4?\�ƅ���997	A�&z�s
g���M �I��za7IC|T]M����<	��
�����i_�M���.� �R�	x6���������5�&M��pS���؟Bh�=*n��58���d� X8:���f�>������������jX����1)�9W���4cd�k��U����Tq�2��~4�yJ�{��G2*���i1ìkj�G'�J6� ��~\/�?���*�g����Q���
�:Hy$�y<+�a���)����}s�]�'o0C+r�nyV�S�)i��٢1��y�u(�
gzʛ^��$��������F���v�m[1�~�%R$������ 3�̌��xVfa��K������sHD��e�%��/� 2
��m��kZή����cKNb�5ޡ�@��3�J*[Y�do.S:�ǉឯ,��ᖠ�S5�
��sp�rP�<���ھ�5lU�:���,��Ĕ*���[�����0I>O��[G�V!���ԧ	�1�&ʅ�旈pV�&+�Rkn�"���N8q6�X�-6�
�W�<-��9ǀX�9?¿XD�0����?�9��|�`��#�gV�½?�;���=�;�5����􄏁����ڂ�x����]A�l�/��k��&��YX�%|����,^�,����U`\���0�����%h�*�
�ҞBmO�BT����8J�(,�@�]�*�Ė����t	�)�a���:'Kv� 9��ZH�{M�щƐ�� ��7�+�O6�<%#WT���xt�Ǖ�b����׻�3�V^U��?R9��=%-��_�b��J��ZLh���C��n���#@��G���$>y�庨�=���T�U�n����}��b��9�9�yQKoAE�e�,M`zo֡
��;�����'���~�|����7�����n��7�y�˳x7�營�|�)��+G��x{�^2.�F�P?Ȝ��HVa{��m��^�痟*�6(�Sײl-��8u��Vl��So[t��Jp\
��:�7y)�RCE�KA�OZ��R�ƨ(���1��)�pI��(�ҥ�e͹�قvJ���m���/�6�h�i���	5�bvn�&��ᚉ���8���v-p�I�Z��p�,��i��C`SѨ�Z�
\}�sV牢E�,Vhj?)������H��?Gsc̪>,I��ʸ�H��]��Z��yZ�I��3\r��eZ�8�ҭ���t�m����*�i!]��Z��:n1�Q1:f��8�,Ĕ�v��j�;B�vic0���;W�5�X���dd���w9p�%תb�E1��ɨ�$4�����X�A��|E�LI��Dak����H�:uq��"Q�H����mLʘ`��}w�;�=��K�� �`��w����{���P�8��h�-?���t���'�P`��?��W��o�I2��W��%�\������W5��d�b��@�@��lֿ?xlBs��i��.�3{�a�/����M<�TA�!E�,�Q��X�_js�oY�������yQ:q5��sh@"����c�I�;���l�ӚQ�D�E`Gv�ɀ��_�7�����9@=�&��0�	�VR��iX'E+&yq�U���I"Q���!0����K@��i^5B��.���C�y����y~}_����3"+�a�6��?�ӰL�Q�H��~�7�~�����գǰ6�hT�ƅ	6���n��֛4K���D� Ͷ�o����$���^�      -   �   x���I!@�u�)ܛ&5Cq���҃�����?/%j@��+��F��͒0���Ѫ�<��"ԁ��+b��"<G���O��(�=W���l�T-@���pT���H[$� ���J�\�U��58A�@��O�|NP�Z�]/��H���'�;H��>A���R�fn�с���e�������΃|�eY^1��      )   �   x�}��J�0��u��˄sIs�Ӎx�nj'Ղ��L��P1F��?�lE7/�q(H����7h��F9Do�������%��.S�*D`�5mK��Yqx��cs�?N�2��b�(�U�"�E��ؗk�@�b[���E�/}�4L1�����w5�LFI ���mJ����9�y~Ni�ؿ�l������R�A�`���?�D7�K<���KS�`���6�\c�d��JJ��w��      .      x������ � �      %      x�3�tL����2�t,-��/����� D��      '   �  x���˒�H�5����D�y!I��(j���5:��w��oU�E91+��_|�{N*	XYa$A��/��ޙ�������7�eC=�z�IC�ҳ�,��$�I���]�W׭�i`�����[Z��;��!@���W$�	.Cd��$�i�@=��?"�e�&�ɕ�8rA>��
�u�E�Ur�v����z��L�����������Vef�>@4���������\ �	"�
�牻�=�o}�EcsW�A�Pce9��tzZz�i���4�[~�:�e�3_R#��YI~�,��%�C���])?����E�o�U߮�a�%�2��wG���'+0�+�\��w������'�W���\b\Fϔ�E�J�PJ7�TTn3v�8���m�9����֏���H�h,���ʲ5=ޜ{�h�.w_	RɀS!~���ȅ�D��d��/vŲ"v?��ԛ8�-���N�2iY�F��sK<n�!5;�2d{ᵻ����*ae��L��3�g������}��0���������R��b��zR��/���7g���`wj�
mV�̚z~<��6�j�FI�8iŲ�v��{��B��L9`�aZlK�H*���`�� �R|(�m���M��w^?H��h���کG|k�	ac��D���㎧Rm���4L�O+��Es��M��k�T�DD.2B+�X����X��}�L���A�̻=St�v��lZ�)1�F�U3���ӭY3���+�!b.�?#��W ��߰���E�a^�S�*Uי��0�f���h�`��Ј�ګ��X��ڲds-�%�B�־y��G�˸ڹ{a��6_.L0/�7V���Mߛ�1	�;��셱�&�H>G�*lX3��~0��Q�����y�@�0�����O����'�     