PGDMP  )    2                |            blogops    16.1    16.1 <    1           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    public          postgres    false    220   �       .          0    189930    images 
   TABLE DATA           ]   COPY public.images (id, url, created_by, created_date, updated_by, updated_date) FROM stdin;
    public          postgres    false    225   "�       %          0    181320    roles 
   TABLE DATA           )   COPY public.roles (id, name) FROM stdin;
    public          postgres    false    216   ?�       '          0    181336    users 
   TABLE DATA           �   COPY public.users (id, role_id, first_name, last_name, profile_name, email, password, updated_date, updated_by, created_date, created_by, status) FROM stdin;
    public          postgres    false    218   m�       :           0    0    blogs_categories_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.blogs_categories_id_seq', 49, true);
          public          postgres    false    223            ;           0    0    blogs_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.blogs_id_seq', 54, true);
          public          postgres    false    221            <           0    0    categories_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categories_id_seq', 22, true);
          public          postgres    false    219            =           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 2, true);
          public          postgres    false    215            >           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 13, true);
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
       public          postgres    false    218    218    4733            +      x��Yw�z(���+j3�:�	 b� ��>%ی5E����I�Wuwh���@
Lr~�}8g������p������[;v������y<|q&���+q~��T\����8�y��b����H�x*s�pa&�,���ku�j�}���[{'�(c!�k�*�)T<c�R�1P�*Jx�X�����^�"U�0U=�ȓ���Ir�K&�D�I���yB�~��c�p2Q)>8WYo��$�7e=�6��f!�]�0�%|xAߤr�*[�wxE�[5h�R����2^����UQ\j8I�)��'~	�Y�E�pwĪ\P�&�Yd凓�Y���7a	O	�^��$(��L�J���%�v&3����L��a�GAO�����Z�aR ��<����o�"����O�En0 �)X����mx�Y�x2��v/E����">_z��Ƌ*S9W�J	�sy�h?��	�����e 9>oH��_��'K|_�|:��|�_���0l�da���R�4�NU�}܍�����P��RE6�L�SE��%�O�}�����c �/c/[|e?~�rZ�e.S<@Zޫ��^���"F*�U�"a�V��R|m��^�S�%��ȃ!Yx@.�g�*� @�	�f�WA�
n��+/�I�+@	���
mIIV@�^��\x��a��H��ۏ~~�ƴB��<6c��%���k������!�4=&<*��� �b�Ļ�t*��ۗi��H�����d�D�t	�<@1Dq���g9��^0C�g�$�A�W�'���/�4����6:U�0×��
�(1�;s�g���Ie"��: ��ć_�n���|?B�?����eJ�a�y`Ҁ�7У��0�3�.���~FH��O4����8J$����}s?�pO�`�K>�r�o��1<Y��y��e8�� R�}  Hą>Qxuv.��v�?$7H�������@g���:􁇼���$ �C��fI[ɔ"����<afΙ�n�rȤ�D����@����s1	��1Ww��r��Qd�Z&�\�qvM�d��%'�#J�9Wy����]*�le���u���gGL�=_[F�)�-Q�3d���������6��i���~[�>��
�A��A�"�Y~Zv<!lǍ��1�a��I���Q;��xJ���U����Y��1�&\v�\�ΊB�T�3T�p����%]��1���̱:B^'!14�b�z�)$��$~�s6Z���9��~k��?��*aV��:�?�%~r~���B��i����{?�w���署�� [W����2���
�p
��H}� � 6˗�F�3_]��ī��iz�'�-�W"8]��
��.1�p�����.P��*�)��d/D��T����K ��gPX ��{��U�&����k~�%����Qo0�4�`r��O��@1����ȑ`W� �M^�|���)(9�`F���G'�X�=�v�C�;��`��?GYȠ�Z��}��]�$�������������7\a��I�#���$>x��)i��\�U�����2��-,*��ȑA�y�
 �
�*~��	0���P�������ٓ7�?^��ë˷���zd��x��߾���K������p�H��� L�m�K`$��So��E 9��Y�##�d�D�'��;@�.j��6���BE����v�Z��U��M�*zSӊ��RT9E,m�� �@����`���� �gG])_cT�*�\.��4��r���$0J�6L����3d�ю�i���{ 5(�p�p��$W�C �(5��f�S1;n�3qa��~�/�����B�S߮e.6IQK�MҖ�,T{l*�tQ+R����I^3��4�"�B�' ���R��T��hnLYՇ�!	��!G/F�iH����H�F)���7�����H3'�m?Ǘ�x`J���ے�`��������B�W*']��Z��;n� N��1[���0%B�]�����6Hşw��±1���杫~1�X���dd�����μ�ZU,:4J m�h2�=	�"E?� l�5� �Su�3.�ih����B���T�u���h�)�1�����e������W30����"J )�2��T�+�p��h�����xv��(�ہ��i�&.:���:�&e��G�8g����^v�����q�O�!�����W�K�W��n`$Dwח��+��7��}�<+�.A�EX?��خ�V/�$��C%�d	�_�5��5恭�S�׹n2�����D���I7@�lM=��d��=��
#��M�M82�S`RD�y"��C<�:d�����`��6���%�/#�F�H.�ajeO
8q�]b��y_��"�� �Z,P���h��\˨P:l��R�+�=���_���Q�˩Rl��[�}t���k_<M�$��_~1�����h ǧ������?���������q�NG�Ӄao4���z̟N�@~ �C�>A�[��c
"��LN�=��̲o�7]0D���`��r1�R�z������m n����۩��Cq����������X�&"{'n��*n3q���B��n�oW ��	�,֑_�o�fo��3��|�d��N�y���(b�DO6����"ѳ[�Xjalьv<:����cE�* ����f���[�/3�7�s���/��	>F8�N�(ASK����d�W'�U��֎�F��NnP��,QÈ�y�LSr�"�	��x{�����A�U#?�pV����Q�� ��or���y� � "=�bJ�S�f��L vi��$D}3�/p�s	ңX�F�l�#�FeL"��=���	'���ń��Γ!���ݿͯA�&��_L��}{A����_���7�W���u��D�d�xh�����(6o䵎���=
X��nX�wy	��(�!�]����nJx�w�w
��4f�du��n	;�P%=��JQ�����J��D�3��@����DƐ=E(k��g�G��� |U�w���ޥ�:y������# ڄ���B26I-ܘW�`7g��dAߊ�DA�"y˧�gca��D%cV���1�X+�������4jJ��0+��=�&3I�*��ĚigbQ���M4h	�8 �P�_E歧�I̱{'E��`:�Yی1%h��m@���a�	��0��q�'e�&'����~u� 9��Q�6'z,�H;��7�Ijm�~�sdȼ����u�~���R��c�R���"}�)`z&}C�>�q�IbE�h�f�7>>.��%�U�^nE���x!���-=OD�b�9�8�G�e>�>b������&�9�6������� �V<Q�;u�x�l�(����ʯ��?�f?�B�{�9�ػ��ܞ�Y�d������f\h.��of�0�bN��|K�::��Ԅ�u�X���_�O/a�B�G�}("� �̉�V�?8P�ӌ�&ǀ^��kQ�� !@؋�����͊o��j ����W��#���_��S��~'���;<�
f�KF~���v�c�����'��㗗�t.����5�M������2k:����<���0��p�ֻ��BW�/������$�;�� ��$<0)����B��j�5��9#�
2A���+�3���ɱ��b�d��i
D�$�������H�N�s�*%2v��I�E߮4����8����Oi:E�������Ff@�� tn�'q�d'y��"��p���>W����r�w�ך�xQR֦)�f�?��'����`�{�����@�k��ZDU������������� mb_<�`Q������A3n����&�)�����9��)��� ,h�4BX�=�j��TBW�72�⏔$W���O�{�Y�}ٺ�o������|����5ܓ���u����TG#�����b(����Um��#��y�Eb�Qs    �Tf�KvF��<� ���7�1a������>�]xҿ�l9�	���_��(##kM�w������y��yx˷M����ҽf��e���G�4Jl��y�,�6�x�>+�b.�
u���Df�~Ō"	G�/���,��b�b��	%�%7q�s����f���cBfS��)��T^aEL�S!���?�#A�`z�T���u�8O;�[�
F8���wD}*�{��Rf�ԩib�¬�B��^�5���w�-)Y�vJ�C���K����tu�K	������c��w ʿ��I�
S���6(h�S0�ڽR�<t� !�j���?3�*�B�N�AN��ԕ;��~��,L�K�j�s!�zN+��$~pH䦴��]�D�טIm ��P��%�T���;Q�#���lj������U�	��J�+쑫���u�>-�v�w�����v)W�wD�p�O%O2�����6�LE�����4�v���i&��HH:-PFSL��31-P�7�!+�~���E�)���D��y��d+ߧ2Q <U��]~��qG�r�"�͋�נjVP��(����ȋ��X��������u���j�+��}�f�=O�k�NQ�܁���j_��YV�=l P`���Q#���^_ok"�!��2�J\�櫲º��L�+5#=Q�G\'�O�;i���s�U��r\�FE�!���Ta�ѩȑ�
tZ3j��z��t�� ��U^_>�k��f+�ܯ�G��M�O�~]��B�?� X����`�g2b�,<�s�觬L>!�?�?�TE&i�1G���^a�c���4�����8ȚS�S�]v���k4������%�u��xY,�%�Ǔ��p������M_���|JJ��'Ә��}��	Z�X��Y��)�O���ʕZ�&�ћ�&���W��3������I��W���xޑ�����8����辖fE�V��=1}�Y�/�������^��{~2�ϓ��~L��5Ĳ'r	�?�f�W0�jc%��� 0�JS_�	�{�n�ܯ�e|�`���␪L�x5/B`eS��v9�=BHy=���W��������7�X	��?����H3���ap�������}X������?��ݸ�)�|	�@W��'��?<9�zG'Ã�JB�&�����p�ŋV�r�{��x����z�<5�S�%W��'7_PA��������zF�_�o��2��

�F��.���Θ���\*�����qFw��ֽ�Č��mibT��X
͌*-,2弃4�t���Iⶕ�2�
�tV����r)V7��K����z2	}�//�#�[�B"�����E�h8�����;ЕK4���)���F
Tf���>PU\�Mv��`ou���^=�O�g�a�{~��z�7`�{����:�����E]�!�<`0q`s�g�k�bHj�������Q��E��{��a�2H�i]��>������+X�م���Z�MX��PF]��̼���Q�#�	�p�����#�e,��� �ӂN:�˸ڍ���)�M��s��D�x�P��f��e�f���,���B���=�)�|Qps����9��˺
{3"�O �,����
����TZ����0F��v�Fbg�k��oTǻ\�e�-�'�Y!12�b\;�>�Ku��}v@�����V.��15�؊Md7��4Q����H��^%G�m��j�3�F��W�^a�,���_��t��2djn�*�降�՚��ϡF�ӄs@��"��h��״ ��5zz�p{�������x,8������=��]$WL5�7���(�%�~ O´������l�J�j�RY�o��ZɄ��h��j�>,5C�2A`��i�T�WA�B_�I��ȹ_�D���KnR��-9^��������#��z&`��I�6�(��\"+��)Y_���+�?�.���Qh����D�w�Xp9�Q�S�4?'�>#F��{���l58_����*}��E�:�Sه�X)4��eX�\L&��[X��T�%p^�\V?���h���T��ù��hcH` �K#
財H���^L�3w�5AS�zF�#��9�(uδa��΁c/��������>B�x�;z�IA�2/�0q�%AJ��.�x�7n���F%���&��YR���а�$%XaJ��t�EJ�"b�����E\\��̋��Ⲥ���~��R�^"
[砰��4�@�7�N2Whz!!���=hI�;a�1a�N��������U�g0_��^�����jB��-ڮsL$z��'+ ���d]���:L�R��ü�O�χ�!�7��t��0=����I��SQA�fs����n	�������2'怫a(S2��_�r�re�b&]9���X��,�G6��$�� F��ezWSU�XkfJJ�rRa��˻��
wm�"� ���X�Ȋj	�c�@Ame�g,)*,	��:�DD�Q�.F�D"��t@�7��E��a�a��Q/X�+qN�4�S�
ܴ����,��[�8�q������ط��[!�&�Y���HSY�����s��29��,�);���s�
{���z�Ĵ�m�j��ԇ"��9�!VR]u_�k&z��nB�=�{���e���S��9h�5��
P(�b.hVޙUtY��.�/��n���X��>��54��n�qOG�k��򼢍��o\w��?kvOJ 2+��G�U�?QIל�H�R�2:�:�@�?4�#�Ό�YD�)��ӌ�?G9dź�]A�GZ<v�К!��^Z�o߾67������ݒ+6����փfUV��V� �d��M��Ǒ�9�:��t=i?x	���hP;���u	rX���7�^,�hˋ��B���i� Qe��3q��۲�
��L�0�2,}�ǈ�z< �$%��_)�FG�P�%��H�M���F(�\��ϸs�m��ze}��r C&Eo0�g���V�9[?�r?��T(;E�&�-�����rr�"�y��@���A"��6s�4��8cD���	1Hi����Ue��<rب�!��!2�\A,h}-6�fY��mW���s�$����S�eY�j�]�4�R۶V;��:C���K�U[�l�ֲ�a�θ�G�՛%Q�X^����G:4���w��3�b �;0�0��~Dh��Vu+�HoYk[�5@�+����!C��|hTˋ�޹n�L5kZ޳�a��e�`��(�Q^�r�@n>�چ%x_>O��ڪr%өA	]��]4��G����(�X4��aF�#H5���xu�*(2�=i�K8ҘjFU�۰u�ڬ����&�a��z'��x`��p� 9��`z��\��[���I��Ѝj$�\u]��Y
��ZL�u� �*��5�ЉC˲�{����q�aX<΃���h]���k�\�qт1�Սs�sJn`���e�%In�Sa���pNf�c��L��(IX5S�=����oѿǙU�bN�7���V1+�K����V#3��k��&)��XW���� <�pi�2_[�,ͬ�Tj6�u���{I"�ېq��j��s��I[7 6���Ӄ����F�L8=�"�lSDF<��R��n�&n���sĉ.D0�$:��{kL�l���������1;.c�y�[�8Σ�,�c�dk �-Q�wnN�j#*m��宗�
�"�Dr��t��ڽ&���V��Rr�nHԨ�g�b@��)V�r+�DvI}��T2�Pq�G�� F�����*(}k��۞Q'��F���Wn��w�&�^Rd&��ٴ-��>쁙��c��,����|g��p�,�<U��&��]E������r��|�z�eD�;h��ǧ�����`��b��t08��G��� 3�����w��8}a��%���+$h���}�G�k1u�h8z�����yj�Ѩ�yj��r�����՘�Q��F�S��a�B�c�:�g}V��F�Q��@��O��,���u���m�ky��=Wg��7��    9���'�VL����Q0�?4q	�a���	q	̑d=�D�J�.�Q�/�E7Hr̗�o���9���]���d�؎��O)�ʧ�!a�x�C�?�[6Mna��|.
R��Ө��WC�9e���O�ů�A_Y���N�� ��$�M&E�p�J6S��2z����}3��T�tQ�`"�v��Ϳ���K�,r�x�ur�ڇ�����Y�ĥ��k!}ݏ� Y���(���%.p�����o]k�u��L��2��r��^W�O�,�+;�����4�I�c�9��W��G����A�&��sQ�l�cc�u_�/��%d�&����V3E���k_��C��rtd쵏��(r�f�6������s�	������?�����:Z8�\L/�[�D�Ap�>m�l�7�g���!�FZ:S����ښ){M}�b�/\��<����	��F{[���	�ϳ2�Y�Ѡ}F�,lMH~�Z�����d��&|�����f|�ʘ�0�p�>U��ڝ�P���I~6~�j�Q�xt�>��j�J;�G~���	<\�Մt~_���ݮ�l��	uE�E>��>&��g�U���K�HaO��Y��V�`ʌ�O\�;��E���+�8�#}.h�P��MT�Ұ����Y�6���X�
��p��z�
�Z�ge���^�}��?*Q��Dm���_G���pxx��ֹ��\@�����?q�KL�T�?oP��%Ia�������Xa�#9��Pw:�s:��L�fS�3��/���S�?����oS�zԟ���M{�EO�?-�͈ɧ�%�Jc�Ĝ�slȞ��wh��,���o���j��>j��D�y�d8I��P�D%�S����C%�O�]�����Mܳ9��7~PT#�s�Kw��W�Q��j���4=y`�bE�&	c��%��|$ܼ~�D
J�[AYC�N�^�F���o�&�$�FdRq@�������U�N��l�@E�*%��6��ԟ�  ��eu]�F�����LDf�2GW+��t�ߜr�(���|�Zwz|<h_���N� 	X�!�u���
!Ւ5�(�����LEaGN�gY��)'A�2�x��vl�\�,WL�5S�kE�Eu]<:=��x���)�9�SU$���6�I�;<@x�Sq�B
S^�V�L�F�2�Z���O�fS�YV���zx.�cbe�6��i���WB."�+��Z��Dx� ����%`޾�S3+<�=�H� N�]��l%H�X�P��"�XF�g��k/���o�E�e]�|~�o� N~��v	;O������_���S,jU��@ ^s����Ѥ}��g����r���i�X`f"�*��(�����VPt�{2E�ޫs������R�.B`\|6q�#d�Ak=�fr�j��q���mĵc%���#z2n�p��Ia��0�}��n�hih7�IVe�.�{�Ǖ|�D��=?��E��w)E�w<ڥY�Wj	�V������7"bͅ�F�;���<R���Y���O��֖�׀,P(@����CaW2�p�5V��HT��Z��]���Vo�S�g8ﵺ~\���D܈$�G���]���?���2[��:*��H�ur�Μ�@�<_�'`0�粛�f��25��a1�M?����9�hs��է�2��}�w��Vt�{����#�U�TQ����].��oؠ}�0w?�=��S��{6N�^��|�pyD�8��o�"����o��:������Ǐ�WW������I���e.�";G���긘{
��A�_�U�U���޷��⧸t	֎x��Y]�/�{I���D����j�E�
燚��7��g[�
Q�#��ǻ����miTxI��+Hu?��{I�\?��]�J#;N�n�h���=܀~��*:��a�D��A5�Aǔ�,B���;A��c.}���u�H&�P���wU�ߛ�Á�>o�q�chGj^Eǣ3�p��7~AE4T�7#�bBX�,�U�~:񃎈�ud	c��Jz��1���31V�ܮf~Vv�#mS,_Ik�N��3Q���}	I�Ƙ�K����a-����������V���Qn��tN���{l'>��t�����g��΂��S��R�-w��YJ���<3�~���h]��D�/����|��i���*�����h�����˛���a����|'�,��h�MF�����ݮ
��l��x��Na�M�tK�C�@��v�����r��p�r	v;��Τ��p��������/H�w>�lVP����<��27��q�؋�Ȭ�t����^��Vw�ĸ8�;�&�VJw�^�{~
a���9Tu�WW�P�*�8�������ڢ����g������&zޑwоm�Ml?L���S��:��\�C�__��X�b�[T���`��$c9:��ÿ)n�d�"�X[+�=v�����~�ͷC�688�i�QNt�����[�����Q��hGsz����Qx1/j�4����%zl<��+���fE��蛽o����ػ��ܑ�#pA�u4>��C��)�c�-*GaW�v�����CQ����έXͩx�@ȥ�ɱ�l��]�{l�� ���� ��\�;s+��6B�d�$6ߝs)���ρ�h@l�N�Ǫ}(��(#�o�ǩzϨ�զf�<>j_���d.��j�0ӁD삤G���(����M�(���J���<��x*�������;abǼ3�B�qfUT���Aʿ����c;��7K���3	��	�Siߖ�����$��<��ƌ�����)o{��I��WK��k�j����E2���TԐ4Ɵ*�4��JyE���B�j�l=��Lթo�����Uk԰��M�L�i�j���<�"��`�wSmTG�34��n�Z�;P0cKnP�����<��潉7j��|2��g2�^��l�)�!V��h�-�z��w)/�kp����J��������j�lw�?��{���h4l{x:���q0t���tp���-"�u&�~�<�zQ��&ڠƎ�����()�c���)�=�~�z�\�Ф`��:�h�J�9bvm7T�ڬ:�!�&j
O���_F��ਾL�3�-���𳹼�K��ء(� ̏��l�fAG`51�U �x=|�T2Ӑ��f3l8�Ne��=��Jي�@�!5)�ik�y��/��JSƓT�Յ�%�]@U�4Ozt!��c�Z'��ƪ�z��U�����v꽯"�"��,��N�H��-���f�ѣ��n3D����>�v���ʶ��}��$�i�=/�G]�2̔���됓�X1�:"cR2��b��[��d3��51�n �MFשgԯDv��	:�}�B=��{���a��g}H�+'$� 5��1�2�w @��P� �:�
���#��0��Z$���2�6ʲs@�uHH�z�·+�
�������/N�LEQ���1��a�!��xC�Ksΰg��H��+v��>q#3��A^bW��Y�ID�n��a�p 윀V0��nM'���������������[:�x�)L*(|���͵|8@�}b�]87�yҽ�&��$���̰c��7�_�|��/�,�i���o�	�7s���~����h�eJ�yy+�R ���xx��NF���і����uX��u�Բ�5\�}�z�ȍp����~�R��F��S��A����\�������t������s����yx��	k7�q�6������ì������u�Ӕ�uB�f2;i�n����	͘	Ɖ�T/b?F!�m�;�|�"O��y4�.��Yk�XeF`��w|VQ�l��GwoH��bW8����!�w7��{��]]T����.��-���v���LU���qW�E�ĴԸ}�f��I3ȨJLPP�Q�5Φ�iʽ8K�N�����Y\ejƸ�jhHGM�&_�5*&��Diz_��9�"Ql=_�D��D��@�xY�hJ�,=_����̼�
����6��L�!;�x�� ޠě�rh�ئBzez�n��8)H�-�];�Ą��Cx<��.3::9n�.�fM�����i?�    6C����9�8"����u,jĉ<�K��IN2�I��S�<z�	5H���-B�|PWji��T��,���1�n��5��1#4+�z�QՌ��(Y��\s78!,ɡ����vj��56)��snWu��]B�����Yf�I�b����4�����r>=�3���*�g��hm�G�\�B�O�*zԨ!��(���"P�X8K���lQe��d�F��6�'`��'YT��V�	�����9���N�f�1	y^7km���BS�&��g|�N%y��ih�����\�����🆝�����u�衣� �� RAu�^1� P�?����tP��ˆ�%���3�1�H�I5!�l�n5�:���C)��6�p%<&@oh<UU�$+pnGV��zRW :V�N��Y,�HV3!v�j���������Hs�����[�7ڋ�}��!
�sK 2�k+̓:5�?X;ø�������=U���"�j����/VF�m��^/]��^vf��qf�-�����v%�:U�6�F�f��Yc6p�Ţ�k:1���
)��9����.����U�ux�(/�D�Act�6x�*��0�>��I�Ӆ�R�eg���V�l�x��D ~H��4Q J@�Dm�,�����gGl�l��L�1�i����|�)��&qЮ�=F��A6G�gaA��TJ^��s��L�.�^R�&�}�|�X�G	�r�Bkޗ5�|�9���d��Ԓݭef5_?�
[0���_��&���aЕ�	��({E�	���.`c5Rr�'	�l˳@w�֒-i�C�:�Ϫ��h��Ѝ�'���u$ �"�6.7�*Gz�O�Ji5N8��^R7����#�?��}
�j�����G�����ie�8.��TyIZ>t� �F:�+M{�]�gZ�C�'��)���/)�A\j�����1���k��8pj�4RU�M��ē(��qic��:K����H�B��=�3t��k�)3*ӓ�x��6O�BP�d��R����5`���.�ZIE@�`���K �wŜ�HO4��"����=��,�`�Q�;Z�)Q#�{��*��c)K%���]/l]�%1�!��
�!��J�f�˵�B��v������{�#$�-Kg�!�f7���x~/�o��u��Y$)��9:q�X���^�\���K��#d5��x�_yz��/J�pÔ_������;9OA���t5��|7��6Dv�˵ݷ�cT�5�ir�?%��]<�	T�]{섻��Z)H'���88rڋ���9�	�F�I+K���vQ�T�����ϟ��
vlpo�`��sAi�Ѳ���w�n�=}yY�Tk��M�#G6��Tۭ�I��T%����x�xU���f�K���I@^� ��}9i7�����	xS�#^Д��X��"�ی��I �hd1�p��(�ـ��7*D��GK*-�qZF���e$���+}�u�2��Ք��0W����{m�!�d�^�\:������`��.I�	H�@�� jf����Zh9��P& 04�� �(��&��"��$����=�PX^Nᨙ�?��^��/��^	/��@�����r����#j�y�� �Z������h�>|5��e�w9~n=��
L�������l�ީS��I�Gۏ�4I��ҧ&�O�<���}Q뎕S���jC�mQ���1�4-�<Y�����e3�S]����=�Ld�[���h��H�+�ֳ��(��4�/�Fg1�j�+���OQ����6��焢0s�q�P>����a�),��^#�h�ε�ۦ}V��e��e�hy�Y�MU²:̎��FZ09j����gLN�z�;9i��vׄr�1m�7j6|��g� �`�>Qf�/�Q�铎8+R��;Ms��W�4U�=�ЫT�`��{aI�@���$>Ys��+���Au�n,Z��2��[OW�,�X�}���`#TcO���'O� �+�l��r=�a��E�I�����1N������I4�a#őD銞-��I�O��5a�ͺ�!Q֙E�곕�Ӛ�ꅒ1A�S�e�M���	Oh�k�,3��ElڕӤ�C �  �,QS�!��ƕ^;��#�r?�O����h��f��tsr�z�� l���\
���i�o@���I^��� f��"���1�5S��r��XvW:���%o|2xxa���g�W��z��(h��w�Ϭ�R���A��
�[��k^��KPq^ ���B?�y�e^a�q�5(U��*�3XiU�/ tSk�*��B�w]�!���E6�V�,��X�R�������c�eG��dOڜ��]�ޚU����h�t'���dO�6p�]xk7H�E9
�M��e2�2O��m!Vr��K��Z��y�(�"LU�&e��K��3�z��G�`lJ����=�&�G��e)�4%��#�\�ڛ�]����сY�]���2�}������_(�#��WuCc�H�b�I�
���A91eB%A0�*=�l�@�vްء�9#��V��W*�ҭ-�F1g��^9$�L�4>�֣p&��('7�\�m��4,V��a����&p�}U���,�N̢����t�Wc���ڠ�TL���b��"�6�2t:}/H�a\��6�B�v�����D����ܫd0rJ�8d$��� �.h�5ο�C��Q�s�K5([IX���M���gt��6L��*@eתI۴��R
Y�N�Bc��p�=��RW:	�ej�B�8Q�>���(2��zf�E4E��X{���퇙9R�ft�`���1�@*�Y��� /$�M���j��v��9|E�5��s<wCd��d�h�l�t��Vr>�8q��Nz�l;��Z�3���K�@5��B���H���鍚+Ed��5Bb3!��)84۞ںI
1х`��3����(�y=Z�-HzU�d�-hͳ���K�C���ڶξ��'H]���f ���Vo�E�3�BS�?f��q���������^<����Ay����Za�ѐA1~C��p�R�����]|��<;N����n��:�0]�P]����}�O��G��p��!~"I���_9�jߊ��q�:y���|S�D紴���_��}�k��G������޺f(�����`�;>98��5w\r0>1���������o�X<��\�Qo ��O��~�I�Oq��^���<*pl̟Ms�`��~�.b���Mg��`򋎜"}���_hW2kUQ����[�
�S��U)9�`2w�g��C=�״�Jz��f�o
�X�߹���*�0�Fs�����:���S�$�\-L;�ͦ4��V���T,H���JGFl�x*��r�Sɠ����b���U�k�jpI��g�T t~�nV �`K���dx�.i2X'N(5\�i*�0��8���]�s����9C�^�luP������K?���^��pku��aK��/�jQ��@4�,����	G���k-DL��|���)���˘�2'�����DQ��v��X�-��\Y�#T�TD�I>��Vu8������f6����Aڊ3HVo	�zhl|L e����K�8�������t$�-�%15m���������:S�r睰���W;��	l�y��&1��tڍ���kľ�W	��?��N�H5ebxؾ��\+��K��ȕ�aFv��&(:���<]˿�����u��41�wا��3@�b�7�H
���MP�EAi�D�H�l"kQ,V �d�����y8��u�L�(�RA��Y��x��)��|��]��y��Jy	��Gk��s��1S�)@�0���"*Ψ�h����h\����f�0��1�d? ��VYA^ k�I:K�	`��
��[!�=�6|��U�@ל�_�y�=�5yB!�@e��v�r�� IfgX5�+@��G����������xt���<6��62L�V��A���}G4v#|~�t���h��Y@lk ^<)�~�T�!�gZ���I&���䧆	�	t�9TɿLNZG�? )ߐ��pٗ"�qi�j&L�5�'�z��ĺ�$�{a�?3�a�B���'�-�j��IH�a�aA�M"��    ��ǒ �T|�Au��{� �wJ<�	�i��Vנ���݃�O�����xt�>�C�����`B���wН�l��|j;$��j��|rP"m�Լέ�)�]i����~ّo�>��a�)�zOx����~�xx��<�]n��R^��Xf]<�Tw> ���x��և}������U��P!?�����<�H��2@sY`�3�	�!	'�u�7e���tp;y�rT�CN���n��tKO�c����ab����|5,ٵFN������$����y�JcdD|�\��1�M�jU�ȹ�(_e񔺞�S��þ��;�J������+I�ln�T@B݇.-��L�Z�`}�yp2Y�s����o�$/ю0�y���V%�*�-�oAؾ�Z��$�$H~����J6��5uK���r?�P̌[9��}��r�)��5$�*�j��HԾ6��b�^�U�V���I_׳�GƟQj��C����4́߾�2(%C��(U��n�־l�kߢK$z�a��Ɲ��k�1Hs��L�G˕���z���ě�:�^�PI����b�n*L��8b8�	���a�	-[�U؍��a�U�?��kL&^�QN�AeW:��A�ڷ�1p��%�w.�S�D�:�u�8��+���N	b$�h�c�=�U��`4~��2YP��0�Z죥�j޲P��T|*~�h�j�S;	�[����V��U,%\f�Y�@H��֖�d:��н�-��3��8���0���?prS����� ���rl��+Qp#�@o#F�ck{1��P�{pNU��� �Fe�F��u���-�j�a��k)y�)�T��L�z�Һ�Df(p=�_%&�g�B�}���2ĐZ��ll��9��s��pu�
%|+� ��1Z�_
�Ͱ�RO|N���rY�;cм���uʽP�M�4�J�%�CI^ v|�A7��J��T��*��A4	H�]M��%����]RRo��ܬ��E�I������1v�Ģ�f2��'�݂ɖ[�2�tZ̹�J��1G�87q!����>��Ţl���i�#y�=��r�@�(�V�2"0c�e���-R%�������<���*����B���V�˪�/�r]O9��̎qTÒK��F������;sI�6^ɟ��a�5I�K��W�<z^�D2��k�����fGwf��3Q��+VUv���3�IW��NY,u_��N�A�qF���{~'_�jܱ��K�]fp~W���	��ر�Y�#_���>�Pa��xU ��"�ںqF�0ۡ�p�;��I��v���)3:���&�?W�N�����Auᠺ��mk7sσ�}9P/��Y΃��ˮɀ�6A�=�-B?ª�2��CQr�SQ���T�S8��Q)"ՂK}�w�٤�Xb��l?O֢�x0*ѩ;�;���:��mS�ACL�.�+Fv�=`(�3kR���`?���	m�{���è
s�ȅ_#]m���u�?����:�mߋo=Zi�ծ�W��������4o��L�)�; ���]L� 	*f�̿���f�<1��
`���us�GG�����M0���X\&84UW2KgE�`>Z��:m�:�/ۗ�J�w��yIM�%M��G������?��A��y���a���4aT��~u����l4�};ҷ�������Jüu�P�v�K��ܬg��[2����|7xs�ś�+X�����a.s�q��1���/��A4�to��i<���n�l�������<�Ͱ:�������W�{}�����`w/~���za��9>R�3�:��lq�+���c�"Q�_���L\�6��UVN(!R2��ę��2�.S�A'{�/�A�!�N��s�}�A���x!��-�rc�l�"�/�[�6=�����BaRq���C�M�:}�:�׃}������
��\�J��CC]��{�\�۝T4�uA���/,�w�;�<d��׾C�Ae�g�r<���;�]
�f����v� !ϣ�_6�W�];�tM[ttW6r�2���{nb���1����ǟ=Ѹe�=ǅ�k�L��������'z8Ԥ���+ţ�F��e�]<�W����W�`�ˮ��:�n��i(6��}�eT�ܶ${�I����Tw̵p,H���-0�n�O�[�LQ�r�:i����^6Q��,�:�p�tR�6��7
GQ��ȓ����}��Px�ϳ�����p�;9�*E����@�����h�;jE�+�NL���O��/A���?�Q��^Q4 3ǟQ��Su�
�3ӭC7�1��K������ڀN��Z�"��A��X,�_R�E������s�UT��'Y^��`V\i�|r�}����a+b��X��Tj���VНc��-��Euf��_�!�*HjD?�<�@b��m�0Z��H+6;:��q4)�s���f�_�ʢ���v/E��=�E�,�Ak�KUm���/����ࠖ�	`�t){9�����(WpW�7��Q��Zt�3Ъ�2-CĜ�g f��~	�r���}����֘�p�6`�<�T��iA[����h��%��d���Ü�MhO��;QJ	�͊q|���t�^�A����������!�*	SM�J�/�	qd�%^>$^�0��JJ6͖��x@����ޤ!M�HK33��$���t�Ι�9�b[�n��;/��}L���	��zhD�ޗ)��dTo�#\�w`�� �3� �;d���[^�o��e������O��dy$�]G���`�.���{BH����ɑ��0�~BUP�V��ڼq����\H�$�P��.m�	��`A���kT����J_)�b����p�J���9��ȧ��f�7�M�2����ಘW�X�(.�+�t$��@&�ˀ���C�r
2r��P��� ���ʀp�b���+�4q�	k�����/�AKG�6*'��A�����Qg�\�[?\Q��cY��I�S�h펮��%�=�&���PH̶��˻�	�#�p��lj3q@,ض��h7����߅2��X����V�t"�N� ���{i����|J�$��I�B�� #��J��Kl���\������* �lƪl̄��+���q�#�9������g�����Z.�`D�e�&��:~�Z���aXu_+�6�̼v�:֓\L6���@�
.P�D�%�D٭������?�zZ�� ��6�xSKN��k_4�:;��qe*�W]���4�a=Qu�kG���b��sf\o4>��é/̬��y�=&�R��~������k����޶�j�疶A 3e�,!�ڢ�Y�4Miڭ��0:6�����Ꜳ`2���Z��xyF�t�Ϡ2�ʽ��,��{I���p|8	�zx^W�J��k�>g��4�?>��$#�Ź����9v��j��o���O��8�l�`�v@l<K3,�6]��=?����4�$oUV�2LAs1J��3Oײy<Z�b����'2��B�6W�(���|R�v��q���]�3O�c��]�w�yN�����Q$���l-��B�b�-�=6L��ߟ���q��xFI^�Rz���/�t��1����T����Mu~�)bP,Ѵ��������"��2,U�|ffQ��t���d��T��>�x�T�u45��V��𹴚Y���;8��O����{��xrrt�B�ٲtǖ��Y��B��QK�U4���q���!�J�� -�)�nu�z�$��]���&Hl���[��N���&ئ��掎�����.L�!P�H��S�5v)�q�Ulw'�eh���br�1��ni�P����Z3%�9�� n%T�&i}�yeT����i�!Q��C�@��hu�$Ps�V�x�G�\râߺ��G��pd��:6�z3��Dy��ڗ��Db&�2S�#��s�p֝И��H��(�G<Z��ǜ��X�Ta3d!"F�o�Z=8n>���۩��yc�#/�:�{�%a�W��� ������Rb&��x����~8]L�Xoh~�O�Қ ���    <rZ�,���:����_Q�3��'��:le�v^wķZI����I_�RGx��*��0�ݛ��\���K�YOR��3�̷��T�zʩb��ve��$��J=)��Qx�|�ÿ��t� �(ΒD��H��~d�K�QO-���p��6��V.%��lo�S&ȍes�CV`ϣ��ɭ�����Hދ�/�@No�hR�7{�P IWB+m�w�kW��7J.�a;?�E�٤�"�lZro6� _]�����M�>���S5O��*����f���h �G���Oi�-�6S� f��\QcX�Ud��e����²S�l��؜�}���x����ǆ	)]o��)�A�@D<_H,��{�h�:��iQ��ʃ�Gm�A�_���fϛ�*mw k�oJ]����������e3�o�ßn&���ޱl_h@
g�j�B
G���b�4�I5�f����=�ZZ[���Z��s�ֿ��S#�' �����u*~$�	v�O�%J���!Xa�PT+�༡��N�]�����*����#f8P�>1:�_!�Q�e��8�	= �ͳꎅ�����] C�"�1b��7�<&ah��R�����{�U���M�2_���T]�i�I<�BnfV���=e:�(V&#�� ��O8�;3��L_�*p�.��W�ӅI�t�Cl�b>���.�A?h_�䓥6�@���Dj21C���:K[��!�2
�r�QN���ܬ�W-9��g�`3	�CJ�:��Z&8숍�Ԉ�lƼ�m�r\�}�L��tBJ���s�r��=�!�����G.Dr��1a�H3�Rt�_q"�u���|���x����{�(N��9�cﳗ����{����e��d�����.Ä���y��+~띦�򟞻!Ȋ"�8��z�a�\���i5�y�?v���vF���֚M�s��(�n*��=�H�Љ}V	Y�'u���Z�P��&��b5�	<
����0R�c?v ��2��j�21�?V�_fxj�&chiR���0��5z'-�M,5O�U,\m�R��̟��@���K�5{ڻ�H�^_M]Y�D=8<9i	Q��(�љ`(�9��ץ��^��*��B�.~j����y�#�)�+���^�#�u?E�y� ���je'ǲ-�8�p\�ِ�<<�#�J�/�ĠFö��\8>�j�?���˟�]l��|EC1
�i���ׂ��`�l�4s���.nd��)�%�mY9�&���|� ��~fq��)	�D�d��+����㑷Ӿ�hM�y����J-���޷`H�&)�}�m�߾<{�L4���������??{sy��%���3������-�8�|����1aVw1�]7t�1MYzC��f�5fݢ��M�alS�m-v��A������
TPw�k����[��=a�s*�̴���h4��5V�,��O�r��{��!
�E���)����wQϏ1�dp.�
����GZ�\��N�k2�}�-�nF>��e�Eģb` F��nң4��T��=����1�h)�ѽ���3H�a�k��R�I8�,֠w�Ljr��`w��r��~|jF}Rp�w������[����%v����Z��w��Y�)��>�{���BJ����h�'Zs/^s9����@����M_�I̔|���Kl�U���[�
�����7��^6:�ߟ/�g�W*���m��lt�������B�[]fُjy4����T�d]��m�pP�6x��9(C����쯿^<�bϙ��gf��/���y���!Fæ����$
�M޴7�	�����0���nRA�NϙV9�ä�"vh���H0�u�I��3���?��;�eJ�P�͎�-𣞸$O ��Uu��R�t�-ș]��d���p��V�V�䪴Z��*
�,"S2�j�]Z�������C!�N\pU�����p�Z���v�Ѷ�%���у�L��r�u�-*�o�iou��h��Xݔ@.��W��Kl�(� ?9��/ˌ�}�1���jvP� �g��M�@4����P5��	�r��;�#L���*��^w���q#�:=;�	�z6ya��#w��Qf����E�dr�+��R%�����H��"��,{�cΉ���y383��<��`��N����*���~���[���b{h=�K%7�c�t,0l�UY[J�Y���G���1<Lŵ�
���ڗ4.��T_`�|��b<9x๱�(��6���޸��8�@jKwQ����ͤ8G���1+�>��J��'��G̅4[��}�D'�<?
�u����ݖ��k��4Y�i��өxg�����2�C���k!٫��[�$+V�[O��c���E�^��,׳XF�,t��?�YL�Vٱ��>d�Pg@��A�O�q%\?�[����ӌ�@�S�WX�hp��:���$\��<��������J��������4\��B�/�k̀�֓�}��-���z�Z��\e�-y�(�@y<Z�2���W7�A��%�������l|��{Mm١�t<�i0m�ֽ��T�n�7�Yo	�������	���>��R0�IE�e�:�橍��H��l�m���Y)K���p�!��q=NƓ�qs8"���u'w_�Q�r����|�_�����n�(�V�D�.m��:��(�PQD�Zw�̄�a���MB�+�Y$�m��塟)���]�g�!&-�'E�o\]�ѩ��� ���] �_,}��3y��5��|�?6¾�[nrw4��+���b���H��K �)�������T�'�Ҧ��C�(*�M�Ӝ����;��Z��&��!� n��I�ǣ��o@6�P�fFl����Xȸ�s���jL'4:��6>��}ǫ�jV��0�
�#׊y|���������{�m���-�%�MPйW���'�!�z�}'ꨝ��ݧE����"���W������rBcO
���>��B��x�=��DJ�{�l%������R3��nL3Uk�d�5M���z��j՟��֟�Nq������x���O�Я�]G`�ղ[}%Ћ;Π#�s�>��	
�LTR������m)��ܡx�_�+k�C_�XY��gm�J7����f��~T����䣶� ��j0��������1�֎���$�̡�2�ҝ��>f��������ʎ�ئ`�3����$�^>(���O� z���}n�u'��uѧO�/� 5��rG�ؾԚ:�T��LЦ��4Wk?>lM���ZKۆ��&����A���*���n��r�C������-l뷗�5?��q�M|ݛ�(h�%���5�Uu�����5�t9����i�k����I�xh��D8�t1�"��[rf��B�2;������@�Y��o���b&w�@�8���>J�B{�����O�������d��\j�Ȯ�D�CZ=<:�#�����8˱�6]��qE~���k����&�Q}�����6{�vAK�7��]�����׾�ܼ��o��ߦ�5����D#�����n;�E�WM��x�)���)�F���!$q��j����76�,�;���bL_�Q `���y����$����fByՙ(�����[g(�E�|a58� g������K��[�=$���T�ʼd��O�����G8^��Dp4l� ��a���Tٹ��W�.ڭJ
���?�"1
F�@��L��|�|��.wz�s�e��2c��{ ��قO�Ŏ]u����v���%�
�f�t�h��Y��p�}J��9��=M���#�"`.�j��$hyW��Fsn�zc�H��h�U�M$X�I��ia(�2���mq�n����#>0�����4���C���M���Ǔ�ٔ�w6gtƧ�E*͝ҏj`c�T[�ww6���~L�C6T��6�ރ�$,��ք5������5��Q%& .u.SU������]��ˇt������5�6`2w��&A���YI�J�E�v�$|�I0Q�����t����O2��B�7���f[Tq�ns��X����q-��Ck~���$7�j���Ϟ�	�y�8ڂld    �b�{���8-"��.����G~wU�A��"\�ś:�'����B�e8��z�4��<#�z�tm��Mƺ
H��XQ �%B��P��E�N����V�a��.���?D��*r/+R��Ý��F��y��9�.$�'e �� d �"	�p� Zѵ[I��X�,�Fy;�[��d���'�[U�ceg+S ����Oh!n���7�-8n�Q;�s�֑&��y��u2�m��?D��X��.�I�Ƅ�[��o�M-'�	�s�E�9n�Jt��a��90��_n,���E��~K�Sm��+~Ͱ3i��Ε���
�|��0��߀��Ww_U�Mn��I��v���Ol&���X8F'ߨ?��֑k�J�I.�(�_��b>���G�_�����
.�cV��ZU�pM�H}@��'�Đ���[�NI���7k����!cL��X�Zռ�V���d�Mh�$�A_�øp��MmƤ-q�7����ґ/�^��VE�"Ń*h;U�t˶�\>�q�Z��k]�q��/���#���n����%<��:O�x��?�378:<���}��E���?�f�����l��tS �u/��g��y:���D��C��j{I��̇k�А��8�]8P	�����AKDב�����8a��<��ݷ*��K���ee����2��f��ܷ�������慕���;��k��K�j�7�?��zc*�����^�#ۮ��:���:�d8��s`�l~V��z����s�aC��a2�x��.���vc������M֒?l�S��*:Ld;kɝ���%��t�n��u3���8�����i1�*u����8ؾg�����X�h�T3�w�������L&�r˽��吾�ః���a�R���mᩇ�ez���Y�Ί*��Ku1��T�S=�Wj��х��-�!u����˳ץTziO<Y��wNG�J�Zv;w�M�V��Æ���,�7��.
F����dǊ4Os�ƓT¡>�u�45+�4�@M}�dP+�U��R�~���K��9 �E6���>��G9����ߣ�A�;��l�iw#���H�(�u���G^V+sL�km|9'9ڵL�Z�zշ*���%f��e�}y2��%�;����I�{u��jh@B	�����ݾ�m,q}���U�����nhͩwt/�h3��o��tkX5 ��G�Bq=J�����7e9�
�{e ��4At���O�E�F�08rGQ�����7,���ak&��M����ak�c路ʊ����lo��U	�����ﺻ�Z�;p�ۥ�T�x��+x���A��f����&MJ���BS�^͋>�,�-��I�A�I���eE=��x����v��E?u�j+2b��҇����N��DK=MY��S����M��q�ϗ]��]���=���Ms��g�yM�>�j��5k3JC�d���c���E$�x��=!^�����p��n8���%�2���Ѻ��ӵ&2�6ɼ�5�ay����Z���fk�ё�f��F2���'���͝&ҍ�mA�k���8�Y���A��E��a^
FM/�6yS�L�H�n���KV�B��\�e��:qkkvOO`��s�2\�@Xs����{l���?�g����$�R
6�yρ�Kُ����G9�O~��ɗ���Љ��o�����Wd*m��{4�މ����Y+����@)�U��'I~$b8=6���|���Ҝ5�1j5���بC[#kv��a��G��U�O���g~,�/��WI��4�<�9JsC+�uk��`���l�)�w�ބ��,�x���6=;5E��[�j3�������$���I[�dlkfpD��}Q��f����%'����z���b�!ϖ�P��x���qm�W��-?��x&��yk�vWR��,w�{;e��e��8��$9�X`��k����Q���G�n�g�5����!�}���V�ٿ��˺�?����w����0��"��/�Ǭ��r�Z�D�n@�ܗ;*9���'��6ڇ*S�@�ܑ4��'e.ief�\eOR�ቜ�tߔ��觙 �`U~b���v8�Ԧi�v��7���W�:�oJ�����r8U���P&�Mg]��Q˔vj�E}�Փ\��%�G���	�&�Ԧo�Dҕ���>Yð�@���A7�y�f�<;K_��s��=z4r�:=H��y��7��,)x���,��)x�Jǀ[ ?�7&SN�S*�LN,��D��	 �!s:j,I�C.IÙjo'(eN��/@�R�A�5��Bg_ͣk�0| �<� �ױc�Y�����n����uzj�:=~�[���$P�-7;S`w�l�K�a�M
JlE^q����wٺbRfN�nQ�y����%y"���F%|����#����΢/-�Gdf�P�O �QpT����,Tp����gG�&p'�S��Ӻ`�vS�x��$,@�]��е� #�9W ���h2:l_���$�"v��L
Β�Q�)��E�++��2$�#8��GhU
	z�b��܀�g�/��c\=�9>�v��<֗,�*VE�. pdK
����j@�5�O єd_��Y�D�4TleWطFz�}g��|J'a�)�	l%ODI�RbJ�=sp�Rx�	���V� �(Y�Y����B�^_X5d?�����
�X�佘��7��i�o�2�'��ӈ�t3�1���C����_R�E���A ��+t�ۘ�%�+Ɯ\^i�/�pNl'�1����P��wpaN)�p޹��0F6EhR%Б�����?�������Q�I�Xh�����\n�,��TM�`Й�777=��+ ʘ*w�x&yڽ�q�n������[�ܸ�3k��,�'�1@w��W�Xr��qM��ȱ�G�U�b�0��FC~o�n���٧ا�#l~�y.U��I"	��#��@]�ɓ�/���T'K���?N�����H�*Z뒎I;KImN+4�܆�~��x���3�uۼ&ǣ-\��w-�?�5��|��EgU��п��d����N�Q���fv�b�������Z�7��Nɷ����e�l�*h��b����DP(N����Xzr���=�g��J[lڂ�v��׶���O��O���'Ã�dt�t|��h�;���O���t��?0%���ӣ�ݣ����H?0�����ӳc���wG����}O^W��<�d����&/�ɒ�X2__a���l����P�Pd�ߗ��'F���}b���A,�dEqI��%+�Y���%��dE?�'+r�d�HVIV�SKJ�MVW�j�����:Y��\��]q�� 2<h}�����������}���4m9����u��'�r���+��@���n4֔����k~�y�M<��j��B1%< �Ҵ��G$p�y8� z	��}s�u�-	���Xzr��(&�GE��4�H����8��hiA$�@$���=_�h�'%�7�I�����|TY�B�U�Y!���t���E,��9n�,���Zd��d}7ya�����˿���qp�'�u�-����Bt����}��g������d^$�3����/����y�̯��<���9�����q���� ����v�������Ru}��:���y���2H�u�8�����H	R��n&0����i��L�N�������vV��[��bҦ�El��w9I�ODO����r���ؕ-�!NSIg��-j��#1��y�:�"�d�r�oWm���޼���6��QM^�k�fiy��f�u��E�I���h'��L���E�8������Z�I��g�۹�d�]8��t0Ӷ��S���`f VhE?�x�A��dʬJ�����Hci����ѽ4
\�γ,��{$��&t�;C�x���}�إ�S�f��D���A
w�JN������ʵ�I�eh�??�ݬ��9>��SmK4	F�&/�|Zn�$������=�<�?��rpU'�`�9gu��x�(̝��' j�NN�2���CJ8\Ww��B����*�ː��%J��¦��Eӂ�����ìj���O������r���\<N�p���*=�$9�b����Jq��uJ
e �ajW�f%    q�5]H,�ψ���p�d�{n�I6�>1B����������3uN?$���?��`yv��y��PW�f�v���t�VE_���*�����5�E�n�v�D$;��t��n�m��s*���Zޖ�/*g\�/����`I��ˉ5�2E�9F�X�����[�i���;��s��_�[\��{�Z��W憎(�]SiEe1�^�_�ա������sࣂ %�|J�_��B��c�����t܈5�i�$��H3�n�*����W�3�0�D���S?H��N�#%�q%)r��>��Rܿ����|����z�s�4�z�K6�n�����5߀�ܥ?�r�~Y˭;æ<>�1�$DrMw?� ��TP�G�Qd#G
;��J�
"��J����ͨq%��^�L��EMQ�r�����X'{�[Z��Mza���ky���:=�7/�%��5��z�����-<_�o�8@xm�$�BbA/A��nIA^ ?c�>���3��lؘ��L��亚>N�yEC ��w8�g������fQ�Z7r�|������i:�ɞ�_$½�6<��CӠ�WK!ԅkt���k���ޒo2��By��W{�F])���hw(D��o���[ IO�N�����w'豯�,�eb���ɒ�m�V��.���7M��Wp�|��x8u�	V`�U��+ɪ~��*Či�L[ڗ��W֞��6�-�H��{j�cH,�U%�ۚ1�nq5��K��뀞��g@1�XhV�|��8+$D;����@�j5B���"^��T3yk�T;Uu.�����⼽1�����f�8ڷ�WMP� �Չ>=���b�I
v:���o�:y-|ٝ�!l���E\��P��^>-�C2�F���~��Ͽ�y����c�p&�&'�pSҁ�������lp�/ٚ��f�� "�4��׋<%���`:v������ �HY=��|�6 C��9{M�㺻��tr/Zx�6y0b$Y��r���9�(!'9w���PbH][�OTTG �i�=��8�l�aެ��1��K?h�j:=����߆�[�A��QA��Z���+� �$�������M�B>#ތ�-���]��p�F���8 ű����zž�:ۿ���G��Qg�z ��ȅ�VR�q}+Q�+�0���\���%`��Y�Ķ��#�aC�-PK����W�2�Bw�Yw�n͇�q�	���Wi>��\�:��bQ��)�R�H��v�pr�[	�^��v�xYv�}��[F���0�P^@�N����4�u����|�],�sQ� 9��Th���|��H�Ĳ
Reoʅ�Ws	�g��t	>���T��LxH!�N����~���k�ŮdM���E�~x	^B�!�f�;碂�=pŲn٣Ц�/��sO��I�	��)׌M��g�.��8�Ɂ<W��Z�&9T��g����('���w�G���3n>�_�fVV0C����~�.,E��;	���뾴i,sܨ�N� �Щ�`n+n���K����*��`�C������*���k�jZ��cq�����}���{{�>��Q�4mz��Uḯ���\�{��/Ai��A'7��x�deֵ��qj�&�g6K�>�`���)җy�52���u�R6$�#��`�e[�G�gL��TXʏQq1Y���6F����R� d�j4ݛ�u����K���Tŕ:K;U��Z�Y	OL����K���1ܣ�G��ݢ��(ɏ���偻�x��KM[�=E�P'�g/e������x�~�/	�'�Nf��_�g_�t�����N�e6p��kαv�p����cu�SR�)/���5����3?åG�9Q0��zh�@�&���E�W��Ӣ�e�u��X\��N��l�~�,�߽�f��1���J�qYV����͜��r�2�KI�B��� ʓHi7q�p^s=H8'2t^��'L��-���9��e��5T� ����1dx�k���S��MY�%V6�+(��*��FQ�kzQ���fj��?`��u�kݣHa��Z��f��/��~���%ݢi���;�q�	4�g��(�J����&�F�Vv$L�4m��)�b�i\������3H���닪j|QDp+KhD4d���kY|	����$-�P�Yiֿ%D_f�����[�Y�T8������.ݷ����YRT0�:2i��܃r�+�m.@�P�^�]�{��`���,�+�va0�&�n|�*��4%Nbe�s`2v����r@�9qҺ	��}|��zP,��[��M�W,�c��I��8u��8�dZ�k�t΍ͨ�$8��&������]T�g�v!�.��b�˪A�&�Q ���=���ƿ�u��b����m��S�}0�����!��t$��P�U)tA�������v�Qy���l�~��xM���!u����p �C�|�t"-�s���!���Cr/��tD�xD�ơ���ێ��1���ݎ�Q��x+��;��XbrL�FѾf��:��t���N#:*��v3�+1X���K��LL��i�fj�H�q�0�|���������6�IL�05u��2A���=L$͉�]E��.������[-0(֧UJ�ѝ���b���B�BG��p���O��wN��G��T��A2�:>{::�=�?;=�5�������]�wG� �~��e�v�N���p,͙���|�^���6��Z�NΟ'���'&�"i�%���e���	a�����3�-�=I�&�C�*�7IK�t�nC��P=�?nS��^r�P�V��!I(�YJ���!7`F�������9�)Ӱ0���W���M^rkMQXn��MΧ��*���n�3��S�A�<� �D� �|�ws:a��k�BBڰJ�!��-����u!� �@9a���G7k<7�O?E���O�i8üJL�ɤJ�R�ȓ@d�"�-Z'��={��"�Kқ��l4�;���^ݜ�$�?�_�Te�s�Z=�a�P,ᕶ2��ku�_�m\yx��p��?�/�L��d�	���ҫi5�yW3)'�]�������HA�fI�	"C��;��х�d�a��O?Ki?�m�YWO��=;ߌ�����pg�8�)�a�	����g��u@�����])�<��/F�P�-�Q[��]�m�̜�}�rmb���Lϒ�%Ω���m_��R���!�z?�&�/�ir@��xMίb�;<�&��	�ƕ�+���)���')�	ܿ�:!�[�o��?%%R�IE(5IE�|�T�zR�Y�T���'.�}��zi''� ���"�"eA�kP�4R�,R����]>�-S���B!6Q[{�2k��N{�>\�QBACs�t����m��͢Ve�z�G`(�H '8��s��{C��D�K�� ��#����P�2��ɘ!�4$������x���r���H������7'�Lj���7'#��B>W=ls0o�|!�3�x���)��N�\�N���{����)��Jgp�Kzƿo9<}�I{�$Vd�/��wD�KgJ5gO�Q�����Tt�eH�==�#ęq&�ƅ^�V��2"������1����k��|_�4�?G���>����I�k�>��1��*r%ނ�.G� _pЧH,��\�YE~�5� ��>cW�NO�Gp�z�@�'���X8R���9P�e	���w-$DE�8����&l�
�k�K��Y��t�U�����eb��GwXF������q�뮌����pŶ�S���*��6��{�_{�������p���h�� x���u^�����ӯ����QtƠ�ș�s��M.�dzZd�f;�[pf����d=ğ�'�E0��x$�'ChiM�� �Z	>�DmK`W�F+�6��i����eV*(����Ѿ��A�B���)w2�EJ�a-���[&�FN�Z�KI������a��Cc��ëw�z����m�֤Z.%S�v����\��)s$��|p�2�6Sva@6\���^[v;XQ�sQ���^ۥ�m�ô��i���5��W%�]����6�*��/�    �����Sep��]32%\���䩀k�	�'�Hf9J}���ۂ�����/J)�ȯ�I��I�;'D��!��Ԍ���8��Ǚ���q�c�8�]8��Dx�;?��DD��H�)���@���.������:4u�C�;��ܐ��qt0�ߚ�q�K��Y5+��'��($��G�i��V:�ɟ���F�V u�pdb�y������}q�~giƽ
;wv��4"?gL�P��I��&�,SrӅ\*�z�����G�}[
�#�,��̌D+$v@W�'�v�.����B�� �+u+��un�A�(q4�&?#[�ޫ@෺h禬;�Ękc�fZZ$<�	��Ţ2ٍh���jEt�(�,@.'���|�Ψ�PB�r���L�⛥A�4�8X��� �5끟����J�4����ȗG
��밆�G3�gx�js��;��͏�wU�Ȑ�����%�z�q07>*O��Ļv�����o$��g��爑Z}x)�Bj�鲺�����Dv*�qL*�MY+��n'��k(N �.9z��S@�K��G��@/�󠝠c
g��l2�"�pѭ]9;�N�Oo~���Љ	G�6kf�Ek6/�1.^o��5�4	:UH�'�F���J-���8���,b:�X�EG�J.��{�E.js\�_u�L��:A��N	Y&(���1D3,������
 
Q�Vp���+����hr�[����&�C�$�Cl�!�?�վ%�AߌA��0"���V�~���?�7��>'��鶼��揤�K�>t,eLK%-����Y��Z��Y���˥v4ږ����6�#J:�"�Y4~��]?O�3��R�,U�z���F ��_5�{����<���yS?J������T��0E�s��IK8�7ݛ�^j��:�_� 櫻�8�p��>��}jΔ2@�p����]ι�	��7�H�����u�{2�d���+д�¤y��7��,8��բ3A�Q�������\��\ �q@�Laӝ=>�|�k����Ɉh؝ʪ."�8ˑr8h���;+ԊCF�ښ��K);D�5D֊ɴ��
}��p��c�P�jl�B����r�ZE�!��7����� �fg�=W��8N��0��7� A?F�J7|�K¡2s:kBNM[B���+�u���F�i�����V9J���k�[�\2q�8LuQDk{��]�� .{�sg9�*���7�h=hEuj!<q�U�*�AI��>��c��5Q�
���I7��^�&�Z��B�r-|M68���i-:w
{6 �I�Q��OƜ�����H2{o�����8�F��-��Vˆ�"I8�')�m9e�Y@���h?6o��+:�u3�aG7�s�L.��XJ!��� ��ĐǐT�m�?h%���X����6�G\�����]�m�X��UP��z,ӻ汃�n[ W"�P��dd�u���ڄ[=׫A�OQ����l~���ꌯ8Ju�O�qځS �fUL�k>�7K6�!�H�7T.�PRdt�|ޖ�����}����=�\��ᱠ�']���U	�����l�+��:�3wt�Bq�SH�&T���%�L*Z5�p�&��s>~�,�f��ֹ �U��Qݴ~��5=A�ཛU�9;·�r��Χd)�����0������c��k�~�'撂D��ƒW�� �ӭ1���L��{���%�<������e�-�L	 �sVI�L�t�V�\=�;ާ��_~�� VQKI�:���#�-�wDTȳ�uTV��c$��$���:��Xe�]#/�Y�/q;�T&�y4mNH5�we��`0������*���X~ʳ�^��s�{/J_̖v%�	V�U����=xO�?�"��@��������-�����+Ｏ�'稻sժ�MNx$�cQ��|{v���ό������:��^۴U��9ds6]&O&�g�C�r����C��Qa��W���_��t���C��A�J��dzt������('v|�}����P�h}i������?��%:gV�K��A~<��,'wS>X�rs��\�ʹJA��ç����oŪ ��D3�v���z֙O�!��< \w�<y�_�[�)�pA\ʳrG
��ޱ��[S�ڼ���оu���Z�ԯ4�ۜKC�!\Th�֢Ĭ� d�ߥ�	��	f��ڵ2����;Z�KO@�����7��sA��aţ,��������Ǉ[S�ݼ�gVVs؅�u���N�Q�m�S2����;	r.,.���}��[ʜ@f��=`�y{���|�˥ )��m�{�j7˶��rb��] =��&��������v����y�~���ke]iQ����ͽ�
m[��U�0Cޱ^���U)�;eJ��e�T��pIĤ
�pÅ�?�����ɋJ!�8�w��%Ӕx2����D8P>���;|�8hS��l�=S(I�t���ܦP�؈n��Ɋ��R����-�1y=�<Q��J�"!����|`cq����^C����%��Ο��/���wC4��n��Ӝ�}bwg���0p���Ē�y��?<�H����/;�XM?~��`7l�'�D����g�~|�Dֹ$D��o�j����,pk���z��� �2��z�s�}�Lw�sk=K�'*����7����I����w��*F���DX8:v�)-��r�K�TL�S㫪ԧj�'>�gJ\��E��}YS��\v����!O�=<���N�����UH��t��rD7qp��D����� �\�v�s�	�@�s�hڱ�����M�8kO�ˌ�u']�S��������2h� ����� *t�V7T�w�8.�%���nD�e�K/�c�py*�Q��tߖ��e���������>FJ�BP>�.�yta\��j�������MGɎXQ��ɰ&arPܙ�1L�L�
�>Y,}�IQ8�ÓBD�j_�a����Γ˿��.���#-�Qh8��t[�Mߛ$��ŅhM�t�m��9�l&K��ϯ�S[�*��g�?~$}���]=���ǚO?��F����5�;���)ZXv�!0��k2�<'ȝi$���ʡy�����M����;��F��k�v�0�>F�s�B3�&���/����O��φ租�+�����=�����q���<��gn;�	�~E)`;7ٕ��gן�.�^�����5Efߡ�X1^9k����e�=����	O��"2!i"_d��NT��nm]Z���&�f`�%��6&O��7�=��_,ry�0FJƾx��'r��a��:��XaW�|HK����3�?NK�ƅ���8w��K8t���n��G��4ɧR��d:ڱ�S\�R�A���FS�<)��[wG��Su�=d���3�E�x8n�]v��ч��:���(�8Q���gR���Ў�e�ӊ�K4=?!;��z�9���%@��.N6d�pcQ��.�O�/����k&nb�%�an8��ɩY�qW,j~�Q�a��G�YA�;��%� � 3�����_�a�������k����
nU���f�x�Y��슁�>��^���*.��x��Plg���.������U��+����ע�"�����"4�@����&`F�)�p�7�$�S?��Hk�8�:9���������I�l~��{>}߳���������IT6���Ť��lK�"���_�|Bl�������l��
����O�)u�}~�3�o�KW��J	=|' �8;�zp�yS�2e��n�����܁C�q��:ɹ���Z�B�'�Fea%�-LV����_�g�����Yq_.\��>��/������!7��eG������	pr�J�v<�n���`øB5�H����䮚J�X1�0maz�N�CR#39�ޔ�YOj�8s�����Hi2�إ8`Y�[f�9C�V���%Z���%�5nigP���3(���H�M���@C�u-�ņ�Ƕv�����p9?Ԧ|W�$�LT�9֓-l�;/#���� J���C��9P��	��L��0�!'���tH6��ɱ�P�l�    �2�g��������s���p�8F�"E�|P�2��U�<u�^8��+%Yr͊j��B���5R]��;����%߼~;<T=���'Z��;��H�a�3}Y1h������o��B����Tz�|d�0�i2eƩ+X�NS��������2B��,�Δي�7� 0R���N��O��4w�ے�����(����kƻ�R�v�i��O��xxm�y�q.*$_�ڵYt�]�3m�AP��8J��&O�gCI��´�Z ��[��6`S�e��h#!� Sjz �7:��.��_ ]�)��U���GW���{sk�愃�3o�=m7&�sC�c���	�6�u�ue
��*�;ō8:>���&������_���ϕ�0�C�3�X&�=:�Ѻ���?r�'?$�uvl�ڇ�m���f��m�Y(O���f�X�牓Q7���v�u����8>�t|zԾp
<����@PU�Ej�mɃ��9��aQ̇���aZX���WC���vd���x���0}�Y"Ѳ��@&;�/���ӕܦ{µ�%����?SΧ���!MG�]*7�ns�,��u!��@w��R�7�u���Tf�ݟ���1���������(����9e&�s�[u�H)q�����X�w�D����L�#��,���hΐ�v)=�
|���z�����d�9pޔ���7@��eN&��In�{9��l5�r��[�)�B�x7�����}5��
hK���$C��-�7��S!�^A��1�Xh�%���I�4��X��y *�\���ܬj��w��J�p[�\���9dDZ���@�q�m��M��Q�K��eI�ad�
��'��A�"�_i�܈���o���Y��lۡ��C@�Q��÷�tkx�n!_��M���\��z촾����Z���J��
�+(���9���Щ>��,;;��E{!��[�<�N�qw
����7̇V}�9�l��mk0�7-c��`X!|E�U�R���d�,�d-oX��X��a�]r��ᡇ�-͍�Gz��q[
�>�H_69�l_���R\.���<Nk�:������j�$aym�b���f�S1���kZ�/��u�>�;����@�WC=8�B�s���!���m���ňW��H1�"����jiUp�mt5-N���6ª䍐�1%��0�l�C�8��aӖbE:��ӳ��`&�@L~�սS3�f�/�}�<�R�O!C5�a8l
s'!��	D��#O�ZF�Z���{���V
���[��_�[-�?3.�[�#���,r�s��~coje7���.�P@V��v�lʪ\�qP��V�,]Uy�vF�3ư9�B>�>� �z�3���Q�ny���"��D�����J�g��[s,+�y}��Jї.M��^��ja���LLY�x����"O׌��N��f�z��`�UD�9`W�[,Ф��Mv;�3��|��� ��U(@`�q���);W����\ɹ�a�B� _l	y�%{"K;���f�{(fk�������2���+�����GK�Kx.}Y=99:�nY��"��n�ʪ0�D�m��V�жM5�2}<�_)��&���g��e.�ں�;W��,(���g:Ĕ��6�A���V]�c$�����ǋjD����%B9+��d
��P|�Y�B�Iz�?��${���\��Q���b�E"�ǵ>C� ��|�����R�X� ;r6��ǃ
婃�H���ͥX�h�g��r���+��u��.�&�O�J���gJْ�s���`˃�g �mޓﭗ���
/���I2����fi�$&�����Yj���O�y��z't�.��f������6�aځ����r�/��1�C��PK #�@t+7�		�q��'��Y�B�I��k��2�V~���{]#��h�B![����܉��H`��P$h0o>��SԐɉi%��y��e.���{�%s]�1j�wx�}DKdI�h-`{�N�c:)���� �#0�y��;��rE�b�0�E7�#���e����OɹɁ[�/�*i�[��c��R�@5$��U��"�j��gR�� X���Ju�\�R���=�����e��' ."%��W�Scf��m��j�7�{o��np)$�� ��r�V}A�|w���?
9��}t��Mϳ��S����n�a,�nwԱ����5�:�7��51]y���``	�P����A�L��d�>O/�&� �y��.��H? 
�\ԂkJb�"��mO^��с���Yw����L�)�5(�����&Iz*�[:O{����K��o�"��@�h89ձHO���鄍��Q�>�ֆ�4`&HB����I/ZG��s���q��9��8���6B2�>���ճd�����.��u�y��4=�Zžcit�Fh@�׹��ژ��:������(���*3�����=�y1 m~��4�u�z�����l���2�7ijNJ�#��I�KW���(��:����p�g���ח�1yl�Q��u�-g�R�Q��ٗ�.�*�*aƅYr�}>oo��W��6?�o��_r�����Pʑ��C�?s*ǁvb.uW"���Q�����s�8у�����] @��
^�i�=�����<��j���@�LS�3���d7�y_w��ή?Y��Y�ֻ�5��%���ѯ%&�C����e�T^�^4��EG�� �b�(7���_/�t�@"�c|���Qje֞���<��hQs`������椨P��W��8����fw�rBͧ��u��L�NO����#��g�o7�EYfځO?��F���~���.�7���?'��?�owv�I����z�����L������o���3|�s�p��V2C�+ޑ�����'���X��gVܷ�6�7�u����%�پ���!�%΃C������-2s��E�}�I�:6EȜ! ��Uw]rY�T�fz�*���OBU"[Kb��PX7z��d�~\�+�C�����\�%���5�jS�of�������� �Gk�$&T�C��bP#��,r��M%g��������D�������8F8��Xh�}����ƿӣ�k��!@����a�ܘ���)7���ִB"LI�Q�ƿ�9L�\sH��:�=�+t�X����A>M&Ř��\�������lk�!?�j�X��C�ۗ�9�����yw&���4��f��4����}@3��F�����g����[��l=��҄3�O 0��t����D'o�\@�$��i��0|�E�8n���-кL�Z`���W�K�%S}��� ���!��"�^� n|��F�>T��LC�?�A8�>�L��5ގ�<96�[d�v����y;Ӑ��_�5陸�Ӹ��3�BK�]�qG��eK�|��N�����Sd_ b��qBR'H�L�rǮDZ�t��=�֙��p��B�h�M/I�-��E���:�XU�l$�Ā	S��+��D�VG&5"ImR���C�fI-�*X(BPvI���>N���R���4�d�&U+�AB;������b=��]��\�ɂɫ�$��.E��X�p}?o��@��űG
>��J-�ډKI�����E�Ҽ��|���Z��(EN��!��wykrI�� �\b�4�y��v�a��
�Q�m�O��P/�@U'ؐM">J��9% -wm]g�k+��|U:y��ԨC��g�g���
O�H\���@Z�GZLL�-�K��K.!��ǧ۵鰭ڻ%5�!z�϶��*8+��$��+o��L{pw]/�7����c�����sܢ��gϋ$��5�sa#S�I6]���Xҳ9�`Ǆ�v���L&�=���D[��v�.�;2f���Y�L�y��*��X�%�m��r�g�_{�.�"��G��o�x9<8�$�Tw�흠�1^B�����?:鹛Bil��a�������R�0AjI�$+<@�����z¸7NP!�Q��o�iq�>$�^:�7"�������c��H��v1��9%/mc�����)5�����@�u �  �h�<��{���o���c�VL�X�%���}V�ʞ��T|�3Ϟ�H�d�^������X�8h�4���`z?k�XtS~6O������pw'>c@�7�x����g�(%t�����+4וY�����50��NH/@M1��b>k�J>n�mKFa�)Fv<+��`�'S�,�g+r��N��e��%ͅ�3�I�A���ں�N�S�Y��*����B�QJ'J�Pb�o̅kku�~�=�6~|O^V�G���"�!��y����泞/x8�>_��y�X�L'��#�&��e�/s*�<�eR�YS��j�H����_�V���ЯAT��Qq�F��|K�/g��4��_׭9��RF>�bZtX�AĐ��G��<��|^�5$-��ܟ���:W䮬@-�	f����s.=��d<ٺ-GS�	�U-�h���a��K�k��ř'�(���j���WwG�d�z��O�eW���HU����ǂ�?��hx���H�����l�"DbLz@�:��t��|�L��J K�9W2p�	��:�}��<M)��q�j�������L�M2:�߸��d�P_P��x��x�P��g'v�)�,��5V��E�/iq���_���jلF"%�o�'.��������\�تE�5G��S����#괝�������������p�i�."	�����f�xO��A}wF6�Y��}sG[��jGۼlm�����������7|<�P�u�Z�|�����x��T���c:\
H����~Q3��^3�?�� �|v��o��%źT;ɬ�f�g�p\[umIz��\�}�2���b'�R:B`��d7�N(9%�%��s����rx\6��%;�W�d���?�t�[�����PB\��q�G��8����[�	⁇4��i#й���f�s���W���z5ڣ��������vm��5=WS����9ƿ����ҔΛ����I�x�
Ѳ��ʻ1i5À�+�rP)��$1é��E����v7��4q�|v�YcmrR'A�=���в��{�������l��>M�0�:Sux���
S�(L0�M:t��0��}�B����[���G�;j۰�/0[]͛�ᣕ��M���ê3�ī�<�L]
��@��2���M����n��뛈����`3���� ��A9��W.�_�I�����=��a����~��@A�@�h�h�S��
�q�r��mΛ���LG[���kWfI���V��< SE��~{���f���O���`qC�s7y��e>��3��e\�}��>�t���<��+������0.��� a��ɑ�RgY���j��*�"9=?���G���(����w}���M�cZ��]cjh<q����KԲ��BQ<7ia��l�!$k���Ѳe`Ȳ&$��/7i�uY�aF�����o+[�p�?�'ʅ�v*��>:.\E���M�u�&��w����E��?���wB/-& ���$}�fm?�qQ���9��f��#ft�G`e���������=O��/��"���+ X�`��ʊǘZ��S@U8�������ܩ���o����W�݉�l�n��;��W�ᮁG��.ZP0 �"ۋ���g��<��Oc�|��%���������'�[�5�쓷b0w��>9�?8��G�h�t4~zt��?>�����t�>p�����Ϟ��ǇG����'���'�������w��Ig      -     x���Kn� ��s�� ��>K�=A﯒�hF�̦,}�Ĉ��#�u����}�fk�h)x�G���"ԁ|��HS���� ��'����=�z�Fn6'�*�6�6��F%�oNx��h ��G��`�9xN�7���7W�'(`=��n$��c
N�����^A�����+������˾�/cs��ox`��ش{O���yA���l`�|)G_[*����eJ�B���������UM��͜|*΂��_eY�_�oџ      )   �   x�}ѻj�0��Y~
���\t�B��^�k�QZCj����WC�K4����Z���g���T�!_�h���Ё��h�S*4b�t��>����hKښ���bw��}��>N�<�o�Q +0PA΋;���$�K2�\��W͋��������|(��RYTޕ�<9T��߇1�w�;�W�O�IE`��2I6�6~=�>��!���@���'�U$q�����xEŀi	e��BuP�0}������Ȫ��Bӊ�      .      x������ � �      %      x�3�tL����2�t,-��/����� D��      '   �  x���K��J�5�+fѻ�.�JQ��`#�(^�Q3����*��t�>-ݙ�IH��o����-Y���=$��$���i��v#=��#����b![4b�U�_��7˟Sr4^[M���{�kv�}��5�f��sە0��	�' Z%�
9P²�dU%��!�}�6O��� nJ�����u��+\1�z$�:����}:�m_>��`�(��c.��i��'�U� �8��;���RR�\YK�]�&T�^Ψ��5+��:&`��N���\^w�5B�L챥�io��d�V��Gڻ�(�B!�����)�e�!~of�d�5Y\F������s��1��e�(ܧc��D��Xr4�3L��TY���-8�#��&�L �8fr	��H�RRE0O�$�+�M�.�_�b�"�NC<o�e�g�;�V��%{7Z�ۃDi���Z/��d�0����8���"-�C �P����̙R�PA9a�V�nX�U.X��m`nzѦ�'��Y+=�|T�'�lwz�������؈�ܼ��*� A,^^�O#RT��V\��e�vROO$���?�A
�M�����&1�'m��[[Zq���g�)K0�婡��?X�fe�]eee�r��@��T=ID�:� NSkG���[�VY���#��VM�4n��<AT�*�����Z�]%d.�r�����H����%��޺��3{�\wc�G����</v��;L3'ˬ�U�9�r>ay��U( �2�_Dz��b����������T�� ��΍�碵�iq*�76B�؇�˔�ކС�3gf��C�-��H����i������O�:�b��(�#VN���E>jK?;�����?����(yq���W)�m�.,-�M���`U�4�����(��(N���*�+�[o4��?;��?*U�C�r��_�D 9�\�r��	~w��     