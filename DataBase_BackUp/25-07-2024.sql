PGDMP  5                    |            blogops    16.1    16.1 7    (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            )           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            *           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            +           1262    180980    blogops    DATABASE     z   CREATE DATABASE blogops WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
    DROP DATABASE blogops;
                postgres    false            ]           1247    181358    blog_status    TYPE     v   CREATE TYPE public.blog_status AS ENUM (
    'Pending',
    'Approved',
    'Rejected',
    'Deleted',
    'Draft'
);
    DROP TYPE public.blog_status;
       public          postgres    false            T           1247    181329    user_status    TYPE     X   CREATE TYPE public.user_status AS ENUM (
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
       public         heap    postgres    false    861            �            1259    181379    blogs_categories    TABLE     [  CREATE TABLE public.blogs_categories (
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
       public          postgres    false    224            ,           0    0    blogs_categories_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.blogs_categories_id_seq OWNED BY public.blogs_categories.id;
          public          postgres    false    223            �            1259    181369    blogs_id_seq    SEQUENCE     u   CREATE SEQUENCE public.blogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.blogs_id_seq;
       public          postgres    false    222            -           0    0    blogs_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.blogs_id_seq OWNED BY public.blogs.id;
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
       public          postgres    false    220            .           0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public          postgres    false    219            �            1259    181320    roles    TABLE     `   CREATE TABLE public.roles (
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
       public          postgres    false    216            /           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
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
       public         heap    postgres    false    852    852            �            1259    181335    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    218            0           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    217            o           2604    181605    blogs id    DEFAULT     d   ALTER TABLE ONLY public.blogs ALTER COLUMN id SET DEFAULT nextval('public.blogs_id_seq'::regclass);
 7   ALTER TABLE public.blogs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            p           2604    181598    blogs_categories id    DEFAULT     z   ALTER TABLE ONLY public.blogs_categories ALTER COLUMN id SET DEFAULT nextval('public.blogs_categories_id_seq'::regclass);
 B   ALTER TABLE public.blogs_categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    224    224            m           2604    181585    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            j           2604    181572    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            k           2604    181522    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            #          0    181370    blogs 
   TABLE DATA           �   COPY public.blogs (id, title, content, status, admin_comment, created_date, updated_date, updated_by, publish_date, created_by) FROM stdin;
    public          postgres    false    222   (D       %          0    181379    blogs_categories 
   TABLE DATA           �   COPY public.blogs_categories (id, blog_id, category_id, created_date, updated_date, created_by, updated_by, is_deleted) FROM stdin;
    public          postgres    false    224   B�       !          0    181348 
   categories 
   TABLE DATA           n   COPY public.categories (id, name, created_by, created_date, updated_by, updated_date, is_deleted) FROM stdin;
    public          postgres    false    220   O�                 0    181320    roles 
   TABLE DATA           )   COPY public.roles (id, name) FROM stdin;
    public          postgres    false    216   �                 0    181336    users 
   TABLE DATA           �   COPY public.users (id, role_id, first_name, last_name, profile_name, email, password, updated_date, updated_by, created_date, created_by, status) FROM stdin;
    public          postgres    false    218   =�       1           0    0    blogs_categories_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.blogs_categories_id_seq', 19, true);
          public          postgres    false    223            2           0    0    blogs_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.blogs_id_seq', 31, true);
          public          postgres    false    221            3           0    0    categories_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.categories_id_seq', 7, true);
          public          postgres    false    219            4           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 2, true);
          public          postgres    false    215            5           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 4, true);
          public          postgres    false    217            �           2606    181600 &   blogs_categories blogs_categories_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.blogs_categories
    ADD CONSTRAINT blogs_categories_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.blogs_categories DROP CONSTRAINT blogs_categories_pkey;
       public            postgres    false    224                       2606    181607    blogs blogs_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_pkey;
       public            postgres    false    222            {           2606    181356    categories categories_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_name_key;
       public            postgres    false    220            }           2606    181587    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    220            s           2606    181327    roles roles_name_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);
 >   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_name_key;
       public            postgres    false    216            u           2606    181574    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    216            w           2606    181346    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    218            y           2606    181524    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    218            �           2606    181642 .   blogs_categories blogs_categories_blog_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blogs_categories
    ADD CONSTRAINT blogs_categories_blog_id_fkey FOREIGN KEY (blog_id) REFERENCES public.blogs(id);
 X   ALTER TABLE ONLY public.blogs_categories DROP CONSTRAINT blogs_categories_blog_id_fkey;
       public          postgres    false    224    4735    222            �           2606    181588 2   blogs_categories blogs_categories_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blogs_categories
    ADD CONSTRAINT blogs_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);
 \   ALTER TABLE ONLY public.blogs_categories DROP CONSTRAINT blogs_categories_category_id_fkey;
       public          postgres    false    220    4733    224            �           2606    181651 1   blogs_categories blogs_categories_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blogs_categories
    ADD CONSTRAINT blogs_categories_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 [   ALTER TABLE ONLY public.blogs_categories DROP CONSTRAINT blogs_categories_created_by_fkey;
       public          postgres    false    4729    218    224            �           2606    181660 1   blogs_categories blogs_categories_updated_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blogs_categories
    ADD CONSTRAINT blogs_categories_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 [   ALTER TABLE ONLY public.blogs_categories DROP CONSTRAINT blogs_categories_updated_by_fkey;
       public          postgres    false    224    218    4729            �           2606    181631    blogs blogs_created_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_created_by_fkey;
       public          postgres    false    222    218    4729            �           2606    181620    blogs blogs_updated_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_updated_by_fkey;
       public          postgres    false    222    218    4729            �           2606    181669 %   categories categories_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 O   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_created_by_fkey;
       public          postgres    false    220    218    4729            �           2606    181679 %   categories categories_updated_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 O   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_updated_by_fkey;
       public          postgres    false    218    4729    220            �           2606    181701    users users_created_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_created_by_fkey;
       public          postgres    false    4729    218    218            �           2606    181575    users users_role_id_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_role_id_fkey;
       public          postgres    false    218    216    4725            �           2606    181689    users users_updated_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_updated_by_fkey;
       public          postgres    false    4729    218    218            #      x��}ےױ�3��v�-� h }oJ�i��HI�8$-�#��(l Ů��� ��8�aN����K&���U�f���y�L��]���\�{6���W>����F��u�.�/�|�,}ޤ��U�v�덏^��*�+_7�$�]�I�<j*�/����.N�إ��E+7����.M�����b5�~J�Mt��[{yV�Z��Ȓ|-_���M]��z�Dx�L���(vU�y_�����vK�_-�����K�(�O��Q�/�i�F��w^�+V2
��(��J�'ѓb�1GQV���ٶ��$K�w��џ����'ѣV�%�E����N�n���c~����T�/�<�� #���B~L2����y���/�Z�������e�jL�X�|5�K����*����F��>�O�,��]e7��1ZUEa��V��b�6+�\����k����e���h�ԋ�O���a�L~޺�����Jq̅���%	���6����l��Ң�1�EQ4�X6��w�l_\T�Pƈ�]3�;l�[z~u�֭o��C�6��Ee%�*?՛�M�2��-��lH��@>�ƃ���F�&�`�"9@9�:��:��RV�����A��Dh=���z��DN�"���hSl�wتXƋ7.�}*���|�X�'؏���\!G��\�ʚ�e�6��2��kd�zp����%�"9G5Ѫ�8���ǁ�ⴐ-�ݽ2����_��s��g��,��^Ώ.�/&��g�����\M?������뢌^i���B�豬.�m�Os�o��{�ե����mY���]�s�5j8���My���u��K��L9��IɨB��^����U%hx����N|v��|�M�W�l���/LP&���D�N� ��$e=�ߎ���X_��<�ܵ�#h���y�"k�����p!�L(}��(|P�~�y7��ˋ-�%�����(p�pR��I���eaKӢ�@�������Z���)��?fb�4	۲9��I~~�-ǋ�����xI=��o��S���o���3Y����}v�9~�YFx��i���JG�$L�Q����!�L�sA�E�."]圗ḑ�~>��= �R����MQ%2(���Q��c�w7v]��!.����wm�[�(�uQ,�$]�6�e��7�ǳ(��I$�	.��ʜ�"�*	З"�D���"��1�]u-����q�D�4��o�ٔEe�Ā�gv*�zB�_��̒-̠�I�8 ���-R���_X˔E	�To�¦��[x'�(�/755P���7A�2E'��e�A��V�cQ@�������n�s�/�!��P[��������_%�����d�?T�8�u�J֡Ǘ�����3k��_��7�(loee2�Mm��>WޫJ\� @ϐ�m�4��ͱ��(9c�$�H5d:�D����M���n� ���m��[��m��l�Oc���`��:e�/�'��)����q�$��W���z9�d!$(({E���*�_�9�c�ݓ�V;�:��uM�'�$+X�LSP�J�C���Qv(GPG��쁞�@�(m߶�?J?�#x��Kh��f�ƕ[5X�RlV̨�-ǥ`�1Tl����Ĥpjn
еl�RP��Ål�|R�A�bѮ}f4�*so�VBg���63bF��zq�R��EVwL�hw���T��IL�9݈�ٔ\����<왪r|�F���\�Fg��m���Ө9�3��B�db��y���'��h�L�ʻ���cI�5��X�/���b�t���U��#c#d�*��Y�jl��x6^V8uZ�}�IT��b
B��P�"��:���N�I�&�V�*�����$"����x��T�'"e�XdBB`��5�<{<�5;*e��0"�\ȧh�Ug��T|6�WQ�h�D��@�9^
%�E���wG�h���8k}�%p��xS&��B����gJ}�!Q������k�Ngq�WN'��A����6�كL���l�1P�p��8Ӊi�J�]9_\a�b���W��H����.�*$���Q�a&��ӥ�3��J��_��ӎ1���`0A'ѳ=��I�D�j��T�~��b�+�g��G&ױ8�N�n|&������meƝR���jY&}'�r�O�����y�ߗ9"ek�X6Rtm0�T���Dx��7�-��ɴt�!+*X����8��Gk��⣭Yy�W�ө!�3�k]Ҟ(5���)*?ߍn��&��ą��Qd���aVax�u�:W��I�XT�2�w�V�R�ހ��s+1@�`�i��niǪ#�b%S~F��d7�`�����ĥ�7M������?H���6�}��ys��4�1m6x��d�������W�B|f~�kr�Q������U����(Em7��N�}ć�yGAc�A!�	�5��mFo}P��*h�o{���*_����L0��tR��bL~'�x]�1Sq7��j�Y�~��.P)�=4�^i	�=�ڤ�ȉ����OL� .�����R^C����s2�^?_���)�"���c0��mJ!;_	����0Ӳ�	o�Xol^�Ƃ�9�H���*�T27�f�8sK�ݵ��6�1���f��|��e�q.Q�A�7��v�Z���QU�#+������Ӣ��$��M��������M��6v�
E~�/��
i�~u�"}�v&����a냷�&����=�q��-d!�!;Z�Q��������<��[L��(�!]M9���tѹ_��G����q�p<r4}Ї/�4��t�k������O��z%'%�L4Z}-��F��,��P���P�Ju� �M�vwO�?v�{�dwPZ�E~a�S�[TF&ĕ�9�\@�U����2^�*�̉d���O%��~���v"d��ݱ-� $O�:�vt��S��d��-��e3�Ys�FC9�;�.A)�^�T�+!��n�я�%�aZP v��T����#����±p�Ȋ��*�v�w�:��k�8n�`2��!�i��������ﭬbK�m��W7��*�O����n���������b3u�_�d�\V�>T�1���R9�Ǭ����}I�
�5�b`���M�[-�"֠,>ѐ�m����})J��X�����H=V�!������@��g"Y!w����R܊��F�'�naZ	m�i-�U3l�j�Ǆ���a�{��=���(|��~RsM��F��X ���"ɥ�c�Wk?��u���<���T�6S-f5ZЌ��
�Vm��ں3gp͎.�Ǘ����|6;>��3x��3��w�������8��tg��k����V�Zd�+1�ͽ�j-���������{�J{ٻ�y���|zyt<�Χ�w�5�����h~t6;���8��u�&K�C��5��7�n�e�J��u��HюG�[�̥ж�d�|y�*jw�i^��������u���#~^�bu�����T>w�wﳒ�'�qQu���W��/EO�q��I�3�p����2їb'um.g�b���g�&@C1�@�ƹ�oĴ��;4{�l��M�=�Yp^T��<���[�!�SZ&��H��^Z4��?����(\ӟ����z!�E�T��<�3_��*�$�5`"ҮQ�P� �D�6E�Xb��-v��J�"!n������#����Se��Щ�.N���ӏ&/'�ùj�үo�ܲE%�&���[���i]��OZ�Mo|�X�ʇ�G�f冶�Ж�$��0N��/��z!�N�7�L'�n~�d2�D����r������]�:��c�����M������C/�\%\S��y�Wԇ�������C!Ѭ��������x:�Ϗ��7�Zft(���QHZ����_'13K`kC7'Q��7��*,�spe�h�D�6K�DO�j�b��$�FtK������-�M���)	��I��N�ڭ�</J2K�j�]f���oL-����EQџq"!�H�vBp��U)��/���
�w��SZ%+ِ:y�o�
=��.�z�o�aI��!_���sɅ���;<*�����z?�	�B�vG    �5^���qɐ��bT�F���z��x�0�+aۈ����h���Xl��r��A�%x��_<|�o\r����UB|!?�s��FY:�����mE�����確�J�\ųɕ�*)r���9t�`E��Ur�
���b �(6�ܾ/���+11��z�U����\�� 1��K���*�x�Ey�ѧ� �����U�&�C�Y�n(�� }�����l��V��578_n�7���틞��dB�zPG�]�0v�d0$���K�M*2�*d�Q9a�­��6{۱�V���T4͑j��Q-�M�,���/��t^�, ����v�]��]�<YW��t����=Ku�ec&�?�S��Q�(��Qyx�l���Dc� �/�U�!o���/'�g���nS�E�G]EU{"�<x6	��n�]c�Y�/"=�3�J$1��1R��EI��[A#�/چ�K�JÒ��
�0��đ-�j��5��/���������������Q�|
^��ı_�L)����rI�VB;�0Z�)�ȑ���Q�*�ٲ^���"S�~=�����DB��&���L `�R<���%��n��O~�;�*����a�A2K��4a<o�Fk���.(1��%���,0v�d�����Mp���D��:���	��_�m���EP0@�m+4)ʅOÌ۷�ʲ�q���Gf��bE��m�z��y�/e�cQ˟�2�� �C�*v�I�ͦe��!*��:1a*3X��ܷ�;�&�[�!�LJ& ��b��5�K<�xծ���*���%Sި�F<��Q�Ok_(%� �V�����[�~�4�� �]��t[�r"<����d��k/��Y&sHi���Ȳ$�֋����n�^�7.�A�̼����+D�r{�%�ADܝwF���U��˱��Wr������+`/4�DTq��X�Ύ�py�X�b��,+rF���{G���@|���7Oze�G�0r@��S-3W�ff�m����<�y�kJ�k���'p|w*tKuӟ@z=�}f��O]��NJ�����z(�W<�|�����A����q��뙟���H�-8>����M�`O�-�����Ħ�%�z��c,IK��6�|�%`M��X�[j�d�Z����=�C�~�qIe������3��Ȧ�toZZz�n��(��u���
�I�֐�����=L�Vb*�=��9�Z��ջ�:���z��de*�K9�ȓ
}?J �u�9=U0�q�T��Zv}!l�w�����ۗ@�-��],��4�)sT��~~G�휍��~(oG'{��(6$?�&ɯe s*ꐣ��!r�5\�3�I�;22O:�@�	>W&#�N�ʝU}�59��Ύ������cT@�o+�[AK�1D�	�!��veE�hB'�Pq��q�5@��y�:|��\Dr�(���{�#��TR���L"Y��D�v.X�ƒ�0�l�M���Sָ�k�`&tYu�)���-�/� {��G�8z��F�#[����.O�Ӌ����� �Y4�_O/g��������V ��ޣdM�Z��w�Xd��u-������O���	��lKQ�I�����bh~9��`8ښ���=.�=��%n�	6���D��N$ńr�<0��n< 4��c��gb�����g��)��fUP��P���F�kTT�, ^7���wa�X�Ta���o�0(EP=.��c���Ա�j�w���1���O�_��<<xX[3V	pO-��!'oc���a	�>��8�1	lr���I4�"z��_IdWb�"�~���2pj�RN*�a�2��"U������1��v"�αA�8���~?��eoɺP��q%S)�0�qũ�u�cLp\Ƌq7�q7����x~vqv 4Xɶ~��B����>?�s�+�'"ms_<��Ջ�a�����I؟}������mt��|��\j����T������(ϭ�v��&3]�"i�Z�$�l��U����i��.������0����W�@��������^����%F������h9�K�5M�P�A�OF�P�T�O|p��n���;U�=��."D9
�3�i�ß>:�"�
Pˠ��,�s��Gt��&�� d������_[x:o�dׯ�4 $�&܁�(��%�/�����-h�������󃴩�#����j�Bm�p�a���a��ހ�˝�?
�O��?��\'�?\	�l�R��C�wg����|~1�Φ�㣳��/��?#,�l���v�U��<�K>�j9���~������O�p�S���8[�8���`ADc p&�Z�������5�d)��J�U�q���HP2nv�I�j��i �Uc۝h��������3?���DR�!���ӳgm H���}L����V�C;Mޓ�n����<�\|�m�9xX�I7���3=����"�g�2�M�泓����q�O?����;$;o��3���&TS'��i��`~��:�������fN�r�ԛ��r��6�ٸ�
���4�AR��� DvoC�ЩO��R���/n�5bqW���+�nr�����b}���I6�����,�_�*��P��}�\��_��!ｔ��*J�F]�Z
�XL���1��Ú�;y��ɫ�Y���8v���ψE(���8��$&R�[~xzz��NOg�d���OV���l:���������/u�
�@V�ç]��<M$��{�.�����t�-�0#n��%
�_����4a�L>\T�52�q��G�Xx!Ox"�m��CA2B|��-���fōū�N{'+A#]�D�fy���+��=Y4t��{S�hG�^Q6�b�@��P�m��!���ns!?��C��) T��c��0 A�ʃ
�|WQW-�#Q�߈ou�JQ��/ 8�?����NI�{{t(���*�����f�����υ��Q=pk��Qr6�8=;;?�N�O�G�h��[��'������=G��-�IG������׾�%
��C�<k���Lg�R�oA?�LQ侁,y)d�2�>%lkC�g�9�w��l�x�hz}��PP��زf4�~�y�{֦�A�^,O���w�&�i���m��ׄf�:D���� M��!��IN���%!/�H�n����k����z�:}5`��#}C�I�}P�T&�/��a�tָ%�6C����㧜���D=;"�H�v��r�
9�[��9��On]}v2��:�fg�����DL��Y�G�~���'�{�P��������_��5GNA*uT_'U���~zE9j�RC4ýQ����eZ�o�K��N��i<?x�Ș���E�JܦB��"R����F��a]jh_�J�����\��#��*zD����qs8�[@+���h��W?����<��Cu"#����JQZ�n�-����`a?��*VJx`m��|E�WD)
RTi���Ӗ!	�o�g	��׼��!"ڲ���� )bm��������^]�)cA�/�W��s5��s�MXt
���hZN����Z~B<<���[_z�p�ʑtIh}�"P�����D�S�G�5�����
��c��]c�i|]U>w"�bK� }}zU�����2�{���iK�+1h*D��M�%T��Rf�&�Ll'u�ް��B�Y��q��S�Z���5�k_���YMw��R�}�l�@�]Mo". ��
yU�U�뼻��'q�0�
=�[�4��&����=�/Kj��ZI�W���qݠ�>��>ҒlxG�u�&1����R���͠�3�%1��0y�A��0^��}��*+Mڼ���NB1ʖ=LŲ�|�H/� �*ߴ,J���#��~
t�@ /�}ne�o\���m��pD��}c�Σېn�l�估5��]h�g/h�\�<G{��1HR�#�,�"CVFj1��y~�3�6��y��Sa-U���Qf�-�q-��R�M��uZ,�nE���N�sB!����.zՠ����j����<�jP�njy���1    ��JAց޸b`��s�S�k���օSd-�����W
/*�}Kٵ��.�ߡSG��V�SKط�����רW�<��� Y\4!@(���X�1��ڭ5�,�Pr���MN�TR��0-�m�^��Je�@��HFx䊢�+P��oؐk�9d���٘{�yVQ!���Z����/o��x��S#O�Y��&�y.:�Yֱ��{FJ�vԥ���P+�=!#���ڊ!z��!���	�����`�@�����r)�)��زc�R.��i�'�M�ҵFsM
�w��������U�ꬳ��cwKE)�ʦk�%�tALւ`K��9�: bmv̨3bF���v:qI�"�;����A� �*�J%�G�Ë�-Q|!ÑH%�6�S�m]~iQ`S�O����no�� �aa�@L7��0TZ���1p&�A"�����V�����)�~��9����L�!���Q�N�ܘ�~]4�=�K�N@s	əi6G��:Z�!1�̀�cW`��M�/�?��*:6��Q�͆5^JC���Q8/T#�w=��`$�"W����H(B����:���`&`ͼ%�#�έ��bSܾp����A�ȤOG�Z�WY�'bk��n���"̰��)4�����BSs��8�y&��5�UX����1T�w�n���V(<P�� ��&=��֣ܵ���/z��S�잦�l�����-�Qk[���K�Rߩ����7V�u���Le���E3�S�����=��u�8���Bo��	FR�ۺH��P�7�N a�p�̦'�X԰o�4Y���Y�de)�N�s� ���U�T_�#T8�H[���u�H��ƛ;�_̋���[�������R4k�
\��U ���'(�+�"d����l��Q���k��e��;a���}Aۊ�x8Ph��_��h
��k��bjft?zKkYt�Vp�Z��e@$�`+_�V
7cיd�F�3M��66�=@)�aĺ��P���=bfcߔƔ,��`Wu\4�h�b>?|Ӧ���Ca X���j�E�
���1'5�I���<x�<�'��E�%��h�
ͱFp�M|DϸF5>}����{�&i�P8�oi,D_���#M�����Oy���M�|A'���Ĉ�������@b�hI��H�P%��f��7��h�  z���V�|�7��%��P��Y嚛1
��J�J����ݏw���೅��C�m�.[�lfv�+E�{c"��N���O��*�Z��%)��g�2���f�b@\{o�H��:�D�;�V�h�mԘ��걵uX��m�լ��k�����Y	�/Q՘�����Y�e� {�bSv�	N�[�|͎/O��G���������p�����}����ZB�,6��o�@����\��z/Ӯ�pt}��c��%�i�4�!�2���z���\RimR
.eD$`R�B$hׁ��?	�f_9���r��G��8F{��]Ɉ�����"5g0
� UjR!��Q����K�%�5[Y�
�RG6m��-�;�:�Z�'F?�;G�h��,��\��j'�旝����O,�I����ۤ^���dDޝ	�C���x25kD���2�&N��ዡ�@P�E�pa(0��J'�>�o|u=�,�Hɽo��Ã��&+�2�(���B���V�*|".�lt�g��پ�KL�`{a$/}ɶNh!-veHk�	�t��0"!���u�XU.��O�rsq���N�3vڅ�9�-�����#�eB*c��2
�h�X�V�Y'pݪ\�X�Yr�+~�D�}�Xe)P�^�Xsľ�.}x�~S�E�u���`��Ql%T7L��i��*X��>F����EZ�|�,g85��ܢf��m��"�]���#��K���x+T��~���'�U1�JFs;��K3������cQU��S��~<�5��M���.�'B!��Jmr�){�\�#�G�J(m���{��O �qi;.̲[A�3�ց����RmkN��q*� ���)�Z�n�h|jpCʊ���@�A���}����b<�ixR-8/(�zX������u�Tॿ޸���~})����X)�w�u<��m1��6GTY[�C�Y����� ��p�O��h�ZmNn$_݈�5;N	B�+��c$>Pj*Sd�v��N�E�A�҈�P�u��F�� �p��p�H+$��s�>s�#���`�;�[��./���e��ʺ��*Te�1K��@��ȑX�h��u�ࠝ�08ͦ���{��m�� �UV,Ď�3 ����j>]]L��f���3�WL�&������}��w�"<z�S�B���ű\���{�h��EW��^������Z�����m���p�bW)m�m�3E���KW�ҵޮ����=���=���b�f�Ce:��!+y碗7����{��F9B1�v5�~���O�s�7^�Q�l���x�Olz�B�ǎ��4�@O	oM��bI��,ZZKdh�\�ຫ��9�L�(љ�)���Y��M���c��'�B�\u��>��}�c.A"(Ӈ��=�f����ꀻ�j����`���v��VZ%�f�6
/Þk�&o�ۙ�"RMm�m)�M���p}z>��rs���+�g3����v�`��L5])p{�����P�U4���,Pμg�J�}�r�mpH��£��N-�R�Q]X�K�ܙ�s�\�H+Rm/�{(rWcL��+
��{��7,���	�hҢ`|Hb$�c�=TQ��+9f^/�b,�M��6����X��8[��f/�ZK��2��>��T텫5�۔�[T��B���{��{�����M�a+�" �b#��¶J�����u�e������M����x"��68�Z��=��o]��������3��_�S�G=?����J��D�cbw��{6�7(=騣�}=S���Zo����������RGgd)s���t0A��X�A�Cd�F��P����h{����!`�9;L	�|�u���*�S2�Ѩ-ܴ!o�OD�X�:��m�;�ƇuPa���-�Eu�5��)��Ԑ�XQ�:O-��K���P(�@}'΁��B��.����ag5R��Va*G&ȭOvP
�V[�P�%8�^�7�s+��g��#�ﶥ�=p29�^ݾ�fz�R��/�g�@\o�4p�h��1���m�3�{s/�dK(F���D�nmJ�D��jy�E] x�����zϞ~�n�؋u�x�3�-�X眚��MW!��l��넹��&c>_�r��B֯rn��[��Q�kS9'Vu�0��$�}Sߣ���P̈́[/���eI�4�r&hd��U�2�߇&
�	݅R����ʸ���{U�m�ٻ�����S'�;H$1�̲���!P @S{�+{J̖C��9r�;�Ru^Ѥ�y������
�5�U�� ���W⢗��㓳�8kk�]��v!������6dd�8�B�0n1݅�3�֮�xSM\U��|�$�Su+<�
%��]���ɽv؎�a+
�)b[5�:G�<��(ܫe(8��̚S�׆���ij ��2�:a����kk�\ؕ)H�h;������Ft��]r�%F'ϔ����.��Rl �u��4� 8�km��Z��Pc�;��t���"Ŋ̇� 4\��s�}W�^u��ɜ�N��y��<���,�/��of�aj���>Sl��,���j��z���'����<��%�o7;9��O���W�V����j��oa�N�e�d��ih�7j�[��F0�G�h��E#sM����Ļ>�*p���%�)�A:�  ߱�='�1�B����1�e/�n �,eٙ�Ƅ����Q�oU���(�)�Ll��h�B;�ԟR��U�0ݲ�u.�H�İ|�2w$D	��$���: � �1��qm��-+%�Z��U�!���T�^L�]��X�#�b#?_��?ǖ��������T�)hvO=}:���b%��z$�����i�\иj|�%��P,���-̖Y��Ao��W�p��P���"�O�Kl    d��5jI�������״��I�!�l�
Į�v]�� �-���Ĵ�)5 $Y&$�k��4���d��C.�4I����	Rg{R�n�6�r.�m��)�p� )f�c���X6�%HQ�e=2@�o� j����g*e8�T����������4c	R>_M"d��x����s��`{d����1?Q ���4Z�t���
g�i���a`15���*D;�ac��j�ǬW+��Su����w���ݸ-c����!T��r�8���P��2��Y���I�Emо��^��)����j������!_�ꔞ ��4�F:�!�W�z�%��4�4��N����A~��� ܳ���+4�a�(`�}���������Nqb��z9��ԛ�	ٰ-���v��ܮ�)ʥ/�G��K�����B��{�T����d�^?d-�%, 7MG`�{��
��JJ_ E��ݭ0�����p�ݞ�.e�&t�W�^��}��M���ꍝstߞ����.4�ϣ���ѱ�n2��t��ٝ���.�λ��'����S��_��!X뫶����H����@~V�6�z�\��5A,����uF�-2��մ���n̳�G�H)hQ��"*��kR.�߁�!��0inf���q�CmН���HF�K �^��,�N�N��h��Z=���t�Cz�k\���% #&��$�*W���c������E>���[�`��:�Fo �0(b��@v7�Io���;Hf������s߬��-]�k��=��ݩ M��qF�n��Y�jD^�:��.F�ٖU�B���>?�����(^<�Z��޵9t�e��a��wk�Ac� M�)hq�	�43V'����F���LZ#����R�j�q�u�G}�	b�����jy{[>�Ξd��5ړ��8>���ǳ9�w����-�
u! �h�D�J��v�Հ~˴���C�B�YA
U�k�Dȥz�hĿ���ɴ�$��@D8HBp�/�v��y���I�<ыYm��#�]���[�jm�&�Q�����j����>M�����+��>Ͼ�������i���_�`
�R7ɒ��Ye��p[�a�s�!�W	i}b��Z��6@��`rG��Ch��?�G�;�2>��-�a�i
�.�C��v痟;{� ܕ��Kc�����Z�3���7��O�1УWU�2��Z�P��^����a|����>�\�j��hg	Gޡ���Gn����|q�{
�FA����ˡ�����A�:�S�Z�]i��s�M�=��/j��ؿէ�¯���h�L5���W�W>�T ��Eb��.�u��) }e� ΀&[6����^���C����8��m"/�|�?�vhV (n|K@�(��u�����|�Ft�UV1�����]o�H(�%�7���jkq��^��A�7�uլꠠ!����1��z�P�óTc+�1sS����=�

U1
q^Z�ZŜ4�R�_:�:Ps�V�ƌ�4�EdМЫ\�p�9����i����_�@W��!z�q!�3�Nq?F@�:��/�u� �%�������-RKee���Cvʻ��"�gG"}���%��9��W�I�����M>��~uG�����0Y�I&6椽>L��Y��'���xvt6=�^86=Y�^,�OO�Kw�:>r��*�����<��yvzq��l:;=̠��C��ڿ�&�f���|J�鲬>��_�繈��~𩘪c>{��N˷�/~:���uҌ����3.��-��/��d~r����5��ءT�O�er����/�/��ۗ��OO>�L����3~�_�L��g��������q�G��L�_�W?�����s?4�|G;�߬�Gp�e�M[LF,��:@�z�C�����Q!��CԿ��\@uep �jU��:o��漶m�աP�q4����%f5��ˤFsp${���|׭�;L�_ ��SLVu�w.�䏊�x豻U<ɖ�Lqm�<jŶ{����j),�P�������o��Z�S�����eh2=f�Ԛ��$���ĸ.�j7�qל<5F�qܖZh5V���_<ԫlHM��L�������Ō�= Jg@���P2ׄ�\dY��α��=Тk�ayE�c9� ��L7F��k\ێ����8�N��*l���l�n�2�W���t"!���9�A�8�Mj�ڿ撚��3z'��dC��T�����xkW��zB�_4H��_:��-��A��ن�mm�i	i���7�|MȢH�����,>��.�K�ךnK�9���L�u�2��߳��,}��e���`�2����Oc�K1��#�G�����~��KUc���
~��,T�x������m��(Y8���-k�Rs��"ȫZ+S�\M�R]���(
A�Bk3���@�8��� ��-��,���S~�6��_�VPq�m���-�]�?��Z]���ح��s��"�}�$�e}!e����H���������@g�\S�2g˩l!krK޹�Ttއ)B���IƵs/����[���f	�WJ�9�xQ<�K�7���M%��-D��nҜ�]Ώ'Gӳ����6��p���dvv2����К�{R�I��|)��_�#��^zȓ{��;�O}D~������صg	Dsc!@nt���E{U�<>��;�VHC�y�^�'�Oj[�F�U��Ǌ�� $no��Kce���z�u7�8�����o�ƍ�ΐA�f7zc�o]Rʏ��� D�*<��1��m��CY�V�u��S��G�4�M/�,�h���6ᮐ.��>�+�4�R6)�Iq��uN��vK~�4���֋�n�}&��5?����_�u�/y��S6��ĿY�����{�	�M*�`�p�MS��e;b��r�()Ӓ\O` �e��#��'���{���Gr� 5�d���6�#;����N��s��T8nd;4*�p���z��ha�Ub��w��&�{�4
�q�;����������.�FYe�NI�i1SNv��ە����k��Z�̲���GL�fg)�
�.��/:&q�a�¥�#-�'�:�G�e��H�0Cni��k7��"8�[�ߧ]���ޗm�Z��#_���%�ݕ)���޳"oC�	c3�]�[��b�O�����w�|)������LM�ʥc�-Qlߺ���d��Ť���>h���!9�%���r�D=4�ww�N�~z9?���O�NN�����}~9�]��&����m�~4��?mv����QFoD�g��A�8�[�|ſ=��V���??89x�D(���un�Bfi�~�U�]��<���:k^k���e�Q��X��7L@�~�8���}c�W���k��,���H�r�=B}-(�T8��G	ke°�ؒ��)��jc���d��=f(���-�(A����Ċl5^tj�!�#|�K�QY!K=�Z�#ͽ�^!(�w�E5tЈQ��c$���Zk;�z��������S�z<`2�;��KKt�<�׌.F���T$���k����,�E�?�o_�J�ͯ?)�:���0�F�B�ۆ�QX�f���
��]^K���	R���א��lk�h�W��u<�����s��}kQ���i0'�Z��-o�Si����!.{�(8����i�!PwOR����b�o�U��K�XW��>Y�∤����yx�#��HP�h�$2wvu��4*4�
ze��:-^�J�6]N��&�b�<�Z<�4h�" -��:aI�^�A��
�Ҡ�����p�(!lIQ瞣Ԋ��
���@B6�ce+�Ȅ�U�%�� ��<��Bs�Ln)��c�����:�h���l�c�S�+
�"dx4Q�1�3��- �e�'��$�n
�/���Td.Vb�i�#̵ן��}:x1H�N��P/V`_7E��tN!�x==�X��t�NЃ���=$O�a�Js���*d6(�nB_7HB�{����������� �l�y�w��Bh�@'_��C��5�ofYQ�'����G���i T�E���߲� �  ]W=
}r�,���E\��N�g��^�v;v�[�p!��e�#���c�>��Kr�*��_;�_�Z ���_�����)��I��N̠�0��B�%T����T�le�
�Ea�%�Vb'W��k��P"����+?짜jv�P���[��O�~RcҌ^10�R��!2%�Z\~��p�8���sn�"���pǺ�"CV��Y�U�F�숖�Ŀ�:	Z��C�ӽ�	�3@�;�����:6Z��J��H��b�9��W@���J�A�b�i�PMM�;;���QFFS4�f^�ԍ�5�(��a��4!�3�Z����NSU�RXq��� �cQ$�6�0
�������*�FD��O'>��!��Q46Ym�`)� O�3X�����Z�7��p�=�b`:���U���-Zj�𻂸�}s������YKCb�Fy��Ay&Ά�o�4?���x~y|<9�]��On{(���C��#s��_&�|����X      %   �   x�u�In1ϜW�=���"Q|K�~A���0���1xd��\		�=�=��h�(ܼ���' ��zA}�	�Za�vk�F����&��H"
G5ƍ�
(�pC�����bѪ���������'Gi^���Oz]��p�A���̀�|
8�]���b��Hp������WI�5_���q;/Q]�6�آ��u�:��`�������Y�9��5�t��>�@���_'��'zi�f���v����z��8�_ �j      !   �   x����
�0����)����I�\vn��tS�łi��o]�(d���!u� `d]�-����`���Ȯ���пE'4��x��%׮@�,*�^����'Q�h`;4���k�'zǯ��	���qߟ���?/H4�ȹ4�/�R�as��4.����y�H�J�U�����/Rr            x�3�tL����2�t,-��/����� D��         T  x����n�@����]�k����R��H�X�%&f�A@����;Tn����39�o��|�MeL��m��E��b��5�jI�������q��ǌ雁鬃	�7�~[�?�Ć���[�ΎM@Q�Ց���A��1�#��#�� ��F{���Pp��ȏ��HDz�&�nŴ��:!���)<0z�Xqr����[���ⰍҞ?�5�_�~E���m�%*�z92����I�j�&D����Y��O���3r9��kv��<�;�\sw�9A�b�'��Ա� �3PO���|i����[~�j�I���P�!�{���40�jKe���,��;���� �p��     