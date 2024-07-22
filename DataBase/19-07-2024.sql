PGDMP      &                |            blogops    16.1    16.1 7    (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    publish_date timestamp without time zone,
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
       public          postgres    false    219    220    220            j           2604    181572    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            k           2604    181522    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            #          0    181370    blogs 
   TABLE DATA           �   COPY public.blogs (id, title, content, status, admin_comment, created_date, updated_date, updated_by, publish_date, created_by) FROM stdin;
    public          postgres    false    222   +D       %          0    181379    blogs_categories 
   TABLE DATA           �   COPY public.blogs_categories (id, blog_id, category_id, created_date, updated_date, created_by, updated_by, is_deleted) FROM stdin;
    public          postgres    false    224   ��       !          0    181348 
   categories 
   TABLE DATA           n   COPY public.categories (id, name, created_by, created_date, updated_by, updated_date, is_deleted) FROM stdin;
    public          postgres    false    220   ��                 0    181320    roles 
   TABLE DATA           )   COPY public.roles (id, name) FROM stdin;
    public          postgres    false    216   ��                 0    181336    users 
   TABLE DATA           �   COPY public.users (id, role_id, first_name, last_name, profile_name, email, password, updated_date, updated_by, created_date, created_by, status) FROM stdin;
    public          postgres    false    218   �       1           0    0    blogs_categories_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.blogs_categories_id_seq', 18, true);
          public          postgres    false    223            2           0    0    blogs_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.blogs_id_seq', 30, true);
          public          postgres    false    221            3           0    0    categories_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.categories_id_seq', 7, true);
          public          postgres    false    219            4           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 2, true);
          public          postgres    false    215            5           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 3, true);
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
       public          postgres    false    224    4729    218            �           2606    181660 1   blogs_categories blogs_categories_updated_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blogs_categories
    ADD CONSTRAINT blogs_categories_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 [   ALTER TABLE ONLY public.blogs_categories DROP CONSTRAINT blogs_categories_updated_by_fkey;
       public          postgres    false    224    4729    218            �           2606    181631    blogs blogs_created_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_created_by_fkey;
       public          postgres    false    4729    218    222            �           2606    181620    blogs blogs_updated_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_updated_by_fkey;
       public          postgres    false    4729    218    222            �           2606    181669 %   categories categories_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 O   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_created_by_fkey;
       public          postgres    false    4729    220    218            �           2606    181679 %   categories categories_updated_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 O   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_updated_by_fkey;
       public          postgres    false    4729    220    218            �           2606    181701    users users_created_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_created_by_fkey;
       public          postgres    false    4729    218    218            �           2606    181575    users users_role_id_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_role_id_fkey;
       public          postgres    false    4725    216    218            �           2606    181689    users users_updated_by_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_updated_by_fkey;
       public          postgres    false    218    4729    218            #      x��}[�Ǳ�3�+��X[�0 �NI����)����P�@s��=�?�>�F��9����ˬ��pH����q|DhTWe��ˬ̬����UZ�e�0z^�e���G.���mM�v룮��|]֭[ɷmݵ���i��\!_W�w�+ڨ-�4�߸6��(C����jyՔY��ȿ�|�ۨ�y/��D��)�%��[cWW��E��6rQ�c�Q�:�hS�Q.�٦�~�V�<�l]���(���.*�Q�־�Ge!���*�Q���o�K��ܾ��eWGk�e�$򷾈v[��=S�2��)�K�����+�6]wY$��|�d�id֮)�f�drXT⊍��˚2���e�ʦ�q�l/���㲓�1�Dw뵐6I�8����K]�x�˂�G�Bآu����*�RY7w�,���.Z�2!q)���8m���Y�u�<#$l�2������k��� �g7��M�Tz�\�`�Yy��m�<v]�2	��*:=��E?�����q^-W��\T�&�e�����"i�̯�0r�n
�En�e�2��O��7xS-Z�7~��䋲�l����f���i+�'y����(K7[��/D�W��E�E����/�d�D��W%��F�iF�:��̅c1�̷`ͮ�dƖ��7��M�V"LI$K��$r��V�p�����V�Q��[�� (�M҈��	�t��N8�mdE�ʘ�i١�Vً��؛�5m*����$����Uʱ����U'k�Jr٩�ǯ�#�V�M1Q�R���Y�`���_޸��\vK~=]���`#�n{:SlK̳�@d�v+tn|��{��JK^&"׈
�E�~��")U�w۽���g-��Y�M������"by1���� Yw�U�LW�/z&�(���xS��B�۶�hB���+!�(�ڌ+�;�U|yh{̢�[S��Mr��)ٓB�ҳ�l��]HF�2�K�4��{Ⱦ�L_U׿d©S�y�#GҊ����Z�.�>m������]�O�ķ>��R]���������c֦��2�O tI�B�/B�H���EX��E?nSѲ��0V�3p�ۏ�U�E�x��R�˂B}Qx�r�?�u��j�5u~_m�M*��*��)��ia
�t�c�hj/��v�\�21��:�	��!��Y�g/�`-��f"��ݖiB��Z�=Ƭ|�F�@vS6F�-�^�Q(�Fd�m-�j02��ئ�d����72I�6y-R�A���z���%����V#��A���LZ����i��"���Xm���A�Xj� i��������"�b�g�s�aUf�&U� k����j�^
�vj3���h�I*A��J�K�KB��8@�QZ�x��\�Y^��-9
f��e�P��r1I�������"	�� ˕	5�,3a�4��EBe�,A˧��1$X�)Y!8,��sjڀ=r�n���Vtږ;�G$#hh���U�����`ao��v{%,PC��.�L�N����7�Bِ��$S��(�5�X!�����L9x?p^��.������r�(;�t꓍�l#ۖ��W��cO��b�;X_n\�Z1wm�I���
?�W��S��U��Q�Ö��&)s���šy���c���sA4t4�P5\IGEx��U�S[�fY��$�"&�	�"h����	-�� ܹM��D�̌(H"�����h� c�FU�ш.�3@�n��,�鮔3E!�*�)��kÌ6���XB�`� �?���,oLwN�Z91� b�"D ����G b�yk����5+M!CU�eG� �/�˿��Ń�|y:�_L�hq�p�|����/�/�u~��d���O���W�Ńo�5�����w��&z]FOF��*����}#�h���Wb̨Em$�q�1��S�'>�$!%d-r;��\���
���m����\y����5�ˀ��E5o��D�g�Ѵ{ V�����J�o��ͅ�w�V�2\%&l�j /�]Eψ��E��NU6���om����v�X�L�����>��?���寗�W�W)�A�J��@�`���p�f�ײu4-%
��r+-d\4���w�w+.��FxJ7��	�t�j��k]��0`M^�r��,�_M���@sN��C��RZl�ZLDZ����,AX ��'���`i�W�e�N�Eo��K�I�P��v�� "L��t0`�@KW��EEɾʿ�²C+B��0Ж��``a�ɝ	k� �ǹۈS[��� ��mۤ�@�Y���=N`tk�j��> ���Ő>���pïpA�H�͈�Jي���j7�b��H����VJ7�p	� ;�D��l��ǁ�������9yxz5;��8_.��=�<`�g���2KE��(��$�k�3���=�ʡǩ=?[B�,�l��mJO`E��U*�<5y�$�J+0�S':5�f&/��0�� ��{�ː*N�0՜��eV�~M�@oKE݋�{C�	l�S�mS%E�u	�
B��+q͍ߐ���.�p�pi%��wL��.�UM���-��2�Na�[��k���Trrl���`��Wa�g�ݛ��H?5O�+T���������m�VDL�V�N����M�o]�yy��̩0=��;Q��sG���J�?Bn���C5��0��0�=�xl��;�a�*���2��p,��ϲ'.P>��0JF���PP!eX`^Y��R�sJH�m*Q���w���:�A��>�K�ޡ�^��ݲ^um���ڍ"ϧ��	�dM�ӾG
�e�¹�ǩ�����Cun{��"E/��!��נ��H��:�{�M��w� &���c�T�
t�D�i3O�P�&O�~�zUUY�]��uU�����27��t�2`R��ưX5㭩:,t����f�߿�#���B`�3ư|��{�[&]���\ ��(�:k3D�F�.��+�K����̮>�̳5�V$�_��M�D�����O���l�˦�[��~u-���~�r�w�=�y2@#]Mʘ�N���0���������rqz�"��S�^�U�
��<!�+��<3j=���H�;mz����;W�B���w��aI��i�f�3�A��(䧓^����7���g�s>��h[��G۶�����)&(Yi��j<nE@���tG�뙿9>zĠ+m)�+�1���c�H.(#Ȳ��^m��\��b��LF�����J�#�2��(h�w�?ie�F?;���@������G�j����f�059���N��`���p=Z�R�m3�������U�?Ч�pTT�bN[������*-5D� �E���N�,��a=k������3-q��`�nK�=9��X��G=�V�E�V�����om�;��Ļ��|�����W]�I	3
&1�oq�Z�陡8>����?)a08�?��F^;��hj�pFU��@ǆХ0`�KM��B|C��`��n�s�A{ZH�ߨQ��LY�|�q�U�4uz��D[č�_q1*xU�AW�	�v��������Y�V?��0��E��q��6Yq|�����>�����,"~\� �u�p|Y 6�=ȟ�R�2B�����1���{�m�� yN�wH�$xG�9��Tl�0�:���9��Y|���̂B��cb���Y�X�5#�6����Lpo\ãL���.t$��+\�'Y��A@�<���WihJl/���i���zO�1������� ��ݦY�[+w����1r����3��dwQֽ�D~��G5��v�E%�ڭ[,1�3�5tĕZ���د�7t��oK�1�T/x_�!��Ǌ���o_w��Yg��1����-���O{!Xu�Í k���S�5&Ԝ���.��[���cZ׎���˪K6���dd����ո�@T?���<chv��+���O�w��7ۏe��TS�bQ8.7n����ī�G�8�),���8�mN�t�j�:�M�D�r!5�A0ԛ��	/�Z��w2J��@���Cߤ����<54*�Ѳ���0�3^Ö������#�+[.�S����q	$�    �1SU��&�� �3M�����(�6ĕp+Ζ���k����
��f+ց�f��ȭ0�n�I��uq�H뵫-:����Nq��A�n:�uv�иp�!��p��]%��U��P�k�
��i��������(�2z��6u���O�+��:�����E�D����f��w�*f�}ܖ+M&x�<1�`�zջ��0lZ=����8�I�Y8���?��,��o�R�]��c�p�����Ou�h�/B��O�$J�!�%l@���Y&��@����8��G4�u��hV�����:��;g��K:P�&_��b���.6%��&.E�N"{��c�e�Nm�+f��T=o»v�#��l���� -��z�G�e�B/���3l��9ƘF�`+/Vi-,�M�!����?�ژڡ�xdS�T$M0���c�u�Y��L��o;_o�"QE�ҵ�ϩ� w�i�A%c�q]�d��/��Nak�o&!��`�	E�(da��{k������/��4W5M�(>�oJ����2�m9��N�b�)ݔ�����z�b8�=I� �����L'eV��u�6=B_X�ʁ�ąy����R����͢�"�7�1�F^���`=`�S 9 ���Ox���y-+f2R�xQ�u��4��&,�2*�{�m�ck����|�VUg���Ӡ�D9{K-R�tT���
894�<+;��(q(�q�����M�&�P	����_"�/�sȟ��JOg���Ff�6�V"���>���D]5��	E+�
�Qf�������|1v㽝۪cHW��i;S�^���Q%���@p<r2�l8�J�������3�ϓ�?-P�Jsz^#�����4�4�e�̅�O>��U�0�������n�Y�h�� ����L�ı�����J�-�uP	0'�Uo&L�r ��j�|/J���ے	@���|Og}9�P�ō���ج9I(���
�K��5����<��(��0+��f@�!ϲ����m���|C�p*R�?�	��8�;~�z�M8���Fn)<���qi��>���}�w��u,����W	E����uP<iI)�!�G���`��JM��p�p��1�3`%~_��c�����/yL(�p��\��S�ޕyff�J��#X��ېztg���!����v%��pX�3� vޒ7�De���	�[��f}����8C��XO�n�`K�{���=�������$pMP_�ǳX ��#��0�b0k?z;�	�G�)0��5�=�1�
 ��nt��k�ֽg������y%��������{�3���+!���D/�Q�	�4kO��k�����ۤ�W$�7�>H��_�l֍��l�+�vw�5���'���r~yu�58;��,O.�9�8�U�����ѳ��k1��a�J��M���Xю��[��e���l��"�Y����4o�$�L������Ŀ�+~_�r}�������2���܃�+F"�`��?H���O�N�n��$����3��K;����N��\��b�	�s=
n�fH�8w�D���1��-o-6!x��	xY��y��.%n��)�)�ӉE���7��z���X�����za�U�T��>�3_��*�4n4`�!c���e�$2�@Mi\���>zZ�W$��7�_�"�*�=W�SY\��燧�~���MG�N�9�d�Z�M
5��G��L���r�в�CL�Ʋ�>}�]^m���\��bf� �v9�_<���`��o7S�v���&|��2�T�/����G��-�h�x�]�&���S���l�m�����c�,/Uõ���c��9f�V�\���[�e�.��?�E����ry:���62�c�h�o��?	�'��*fN&�4I1�`؉�[�����U�#l��]�2�Gē�;��PjR�y8jTE���Ԑ4�y�,�([aF	���:+�:6�����h	*gd�[3˲8�Y�-��-�rr�4�ZT-.�N(�
��pSZ���o�sᣧ_(�¯����O��Ο�K!�/��a��q��ܞ�k�t�S��Vݞ4^���dh
�z��r��z�C�ǻ�U�(F��-��h��oR 6��2ꈥ^�-g������ڥ7L���>v�0_8��ϩ�FY:�V��+���SD��_���o��
A:�uD�g����a�t]6�(�bZ����9r�H�Qmھ}W�������X}}�e�����^���`�DH�f�D��eb������ͧ��u�qL�+�A�^���i���!mr�^ٵ(���d��I�94�h_􍠈7̯�Ic<��!'K�
jr���a�+�=������L�k��.��9�����j3vBͽ��J*�� ,Z;�@��5�����N�~�M6�E�Ѭ*�,�-��е���	=9��Ś�+V��覘 &7�􋟋ŰA�.��LSF��y�ө���佪�'q�|���L���>����kM����Ĳ��N�1��6R�We�4`�*#0R�����4,�d
��ZyQ��N�.[3\3����$��8L��� ���4_�X|�F5�,"q��{��}�hk�f]-�3b
ㅆ��i�EA=JS���Ƕ���i�@d����gq�v>	Nj>BǠ�i���␬P�'��ᅐ����q�ͯ-^�aZ#�Z늬V%^��Z�624�����q����Cڷ<Lh�y+�i�����������ҔY�׊��(
H���?1.|0��UU��"�;���X,�7�d����z,f��X�"�������S�-
��̒B�ĔG��[�yEw"2o]��39�� ��5�@=�L=�
,�Rt�u���.WT�(-���8��KC�$�����S`j��"x��G�4�S�Xp I�质��L:�dH��|y�ɜVb�)�7��H��Y�z�uѷ��ɻ8)K��Rl)�k.	 Y0Hwу�w����Ʃ��W(����_ ˿B~#�8z^&��q��)/WI'(|o�,F��-�S;�޲����_����X����Zf�1Of��	�Z�q?�-�� ~M�1C����J�o��������Ȗ���SY��̪v�.C<���[�
W���h��=?;`���8|;H|&O��ۺҀ�߈����#i#��h�ꃝ��K��#�sD>:���F�]�oam����y��A̡m�l]Z��U�"?����A�C?OP����^���E~�>qk����d�����X�Q��M �=P<��QIg/zF�sq��7�w�u����z�C�^�@�'3�~�B}��Kz��l��}ʥB���JĒ�REA�70�d�%8��.�`>�n��\5����(�����������jQ6�,��ҺO�nd s*�pF�-+��܍/B)�PP�޵��M��
��4�ܣ�������;3�xap_�`;P�\iX�]-�5������L	��Oȕ��f�z���v=k�v���uZ�J�"X5 x�܏�	ZIS����a���L��k m��a�ئ��ƅ~�h�3��z^|���7#�w� ���&y�bEB>�X��\,�-g�W˳Ӌ���h�|x:�Xή./O�w�'�+j�=|�n��b�nDu?=����y�#r��']%F=m�{�|���&,M	�i�68x�x��
��5��&o�^9�3�%���A\��H���[�?��{���1� �>dxhg�-aY�}$`�'o�Z�Żi�X��f"Zǅ�5SP��fZ�K���%�S��)�1�;�ܺv9�2�jw��ѣFĚ�J$�4�y���Ԃi��6���1&"���?�%[E?��g2ٵ��L���?����.h��:$�7�2��I���bH�l��i���%�n��ɴ(GS�6���.KV*�讦�Lu�LA��NkNu��b��*^M�	N�	N��ˋ��#��Z����O+�zo�����zv�կE���-|}���W/_�Y*Ae=�@�C���$��r�����(�3�S���.����<h�cAf�e&�&�@X؍�(��+��ET�
�#~���ډqGh    �u?��*�Ȅ��򘫌�;al5 T� 0�U-�=C�^�܆�8�Q1�GkG4��@e��&����=�S#;��Ǆ�+��vZf���}9�kYƬ_a_	f��}h>de�o;d�?�󵕧�f�2�*�Bc لX|�ָT��U����ǖ�|q�#Yu��Q��G��UM�E�P[1^`X���4�B*���b�����?�7���iw�EM����X����r1��X.����|qzrqv�{��OK�;��9��]��%_̵.���0������O�p�3ҿq{��?䄐���	���Ql�?͘�J1 ���a�� 3��t減D&Ayȴ�W~���b�����u����Ǉ1��g~�iW�%
���0={���d�=z���: ��R��=�٭l�q�V'۫ow��G�*�tc��Ӎ��/p^`{��a���b�8�:;�<������C���	�.<G�@�m�5M�-n�k1��r`���v|~�]ҥ?����±������n��3����{�=����[�!S�ͧ��g����ͽA,�z�û%�M�Q�I�Lз�M���y�u9�}�������8�/_����V��2:�O�bڨk��K�$�7���ɻ�N^����ڈS7���g�� B6{��!���K�R`J������_��/��j�<Y���g�b>�����E����Y�6p*����C)O���e�H�ǟ��$�0�]`I���W.C��:K#�/Wu�B��lݶ�V<Y(R��a�y(XF��ƣ�%S��sj^ގ���s*A�>E��:}��?�~<�Ec7N��Ŷv�KL���H.&A�X7��~n������$���ɓ����jr�u���#�Typ���l��1��hT�ķ�[�E���P��췂�?�W������4��E�ɿ�z{�v������3��\,��/..���ӳ������18��ORP����<	��#[@��^�R>[� )d��+vW���K5�!�X�3C��-t��fHK��&�Alm��B[=}�T��=��?�E_b8T�Y&X�@3��S��.ka�@x|�by"��6�_7�MCN�J���fj��C��U�m��U��`�Bd�%�\��6%���L��[�W�#��+�IѬA�3�D2L���BNe�z4���Y#I�l��7���O�q��(�sh������ �<��ؑ�0!m�:��3���V_��ӭ�2Z\<<�z8��Z�/B<j�G,u��"6������S����HW��_���P#��`Y�@�F�No^�n�i1�T�$��o�����x��X�ջ�x)8Ԥ�����F�b(a��$�YSFZ�_EU}U��k V����V�1X�
��8�>N���ѣg�������q\��2�;�&a��*{!��&+�#�ge��'b�+ƋB�W�y�Z�����0ء/bT_`3���(�FC�l?-���<ݱ�ZtU^Q��"�WQ�Nh��q�֞r��Ͽ*��pK���q��o�Y�����p������;������Wr�W�!"��(�w59����Y)��7󋫓x}��+�
|q��5[+������f���Cۙ���P����N;�0?�f%Cݤ�=V�"�EȠ�e���F�}m�k�^��Y�F�Ѝ���U�e�����|��=� �B����2�O�49�z���|;��2���y���$H /;DP��!G��}��8�ӓ�dfٵ��cC.� 4=�[��Y�����uX��Fф/�o	���`�O�S�M7�H,#Y;3i�_�,�A���h���!pj_�����e�>��W ԇ~��N3�n���u���O`,8Yc%	�|���nnS�c�Ȩ��&U��K;�ay.�M屮@<E���쐒�P{V��b`{��`T}+n1�!��?~����tEk�:��o{.k�r#qf�B�Ð��-�qk�3���C� 1�;�����0~�rCT�b�h�*��v�	Rݭ)�]��ǵP�>��w��0a�l�|��C��p��������х�e�������A��!Eƺdksy0��UZV�=9����,��3�k��
�p�#��P�v�-�򾊔ݢ���Ry	�옍*��[��s���k����Nz,�D���>z�u��/M�zb)�T!E�@��7�Gl���C>���)�K���}�u���pz����rW�1�*4Ϭ�R�`�K�${�;+(,�������+�Y���e��F���o��c3�6(X�������p�Q4��ҡ��Zr��
Agv|7ӣ ���v�l�J��V�����j�F�96�O�vģ�=fn�$z+�݀6�������P��RXT��(GuZ�N�d<�L;&�-�s$�����r��}L4�X�c��:���-��d��3�C8���lD�yq"�';!���2�\/І
�/�m��W@?t_�?� �W��6]�Ɯu7�i�1�yz�>��'��������juz~v�J����ĭ��xyv|v��������O����8�鮏��'�K�v���rN�:��/��[�E!�舽�G�T��ه����z���'ӝ_ݤ�_'�V�sZ�o=��d�F�����I����c��ɘ2 �/�I�~
"+=����8����}~��{zz�O������{:��/�.�_f����,��=��_}O�t��=Յ��~l��������c�lƿ���/�5�0A��vZ���$FD����v�I:�I�]���`��bv�����ސ�&>�y���X���d�<5'��?G+�|�6��CN�g��$��}˴S_���&���[�I���-z�����9(��d7\��
��d����c,�X����������F�S�j������t�IOo�i�IO�f3mʺ�O�SS\3��)1�T��яi�oh��yn��G1�.0��fX�mM�>�Pr׆Ff�,�}�T|V�#�/���i]F�g	,
����������_ GD\:�/ܠB'0i1ﯾ�C7^���M
�$�i��J�qkKXBƌ5���M�k.������nԏwB�	��I��et5ϻ�ן�+t��ߌR���P@�]�)�H[��vi���/�H(�}4��}��uokE��Nc�ӥFʙ6��Ы��fx�I+{Cg� ��)Ҋ=���bF'G�sG�'1��`����ť%�u����ʘ�č?6���U֩ϒ���K-�`�B�s�5���Z�_ҖGP<N����'z��^�(����3z\�]gtS:���I6B�-t��V��m�ZJ����v������(�z���uc�m�
.%�������=�D�푬G�nh�����
tњ���o��x�ۆ.��'�����9QG�=8�ֽ,���|%kr	� �������	�y�Zu�U�U���$
���8��^4������ֺ/..Og'���;��<78�?<;����'��h���ˋ�������d�qn@��
W��7i�#Rc�1A8X�b�#��>Cxl1�r�-�x�uzcsID{�m��i �E�x̢��2����m~\���by�xD3]�DįO�Sܑ�?z$��ֆ���}{DTk���im,�3-��U�T���9_�k���x߲����T&szqDڎ�CZ���͐Eig+-�E����n���������|x�(�f��yj�r��4͈�=�b���h�&�i_����E����8P�Х�P���P�����l���!��k�ţ���Ni/b�g���g+��̍k1M.�2T|�6�O���S�R!��,� 5��+�mh�KUE>Xg����3ڤ����v��4��m_���^ �`{P9¾N�>�������Jʦ)������:��̓M>�1�~�ʆ!-{�/�����β�A�(���E��L�"/	��hs��1����)0l}w�Җ�5D�<�څ}]1��&�00�w�Yuڻ�b����ʧ��ȑ�R�����zĐuOH�g�� &�'C�6�����?�8s�e.8.�D�V�}k���d��J:�/���z��k|��GO�.I� LdM`��>n��[ˀi� �  փ�
 ��A���|����34r�e~��9
MVzH%�:�	�e��`��V����/$�]�؏^�h���[�_,)�L�]E�����zxl3.Q��c��o\1�h��o�^E�D�w9V�:��	zW�j�W�"�����Mأ�W��x@�nL��]����3ص{�Ba�1��F��-ĴC�6�~r�$�3�#�ǭ�W6�B4#���S���V��k�&Z���S�[˭� �</Y�)���_�ĤM�ƺT���tE`;6<F��gzJ��> )��kF8��]�1���'���
�����:��R�u�z�!0�y>�����~C���liճk5H�iuj���x����ަ�7j���~�w϶�DK�٢���I�ǒ�+vj�簨�^���� f�ce=�'���p뀖?���Rks��j�-��%h����h�j!c]~Uw[K�v��������D&wI`�X����*H�XYI{�����L%c����q�z=�3�7����v?��@ur��	^=.���{	��o���ҥ9�(�x���W)N�6�E�Z(� �CKܖR��OD>�R��A��A�5���I��:Cm<�s���h�$z*�w�z��XǨi?lʏCss�0�f�ѩ�sg���V�/l�Y,�/�A�����j� ����cwkO�c�@rj�Ŝ����&[O_'�v�9`% �Z~Sh�s��'��+�_��h�A��;� =�����h3�_�w�E�Qw���uP:V��ߋHG�w��%�5X�<��.�u��fG�SoL�D5���lE
��U�
Ќ�=������A�"{��4ȶ.��h$�7�Đ� '����,�PvFkw��lׂ�>���:]�����$%��67	��@Z���[4�Q�D�7o���D���|��V䄻��Ǫp	��P�*��a}?6֛�V�0��Q���:�k������5�6��0d�@G[�'�g����v(��aB"P3��1 ���[�cG����#C��`kWk�:[֧�d��KR1��0��C,�X�%�0k��CGw�)Y;���l��A����M�/��-�!�5+1���Ŕ��ꤦu[1u�>9�/���k����	{O��'?<��ӑ��w;
���Mz�����E,zïbz �+:Y�[�"�����Bڇ`Yt�&:�tT]��
oR�tG�Kco��^w�(^��^��!/�o)r�*�ְIPvw��u��z%���xנ��"^䩽%P��9m\�lfiC�Ǵ�D��^���PU����ή.�d��a��pbp�!b�^c'tDD���u MBF�y�<�w��?�V�f�z���� �.�*F5ᅩ���<�䍋�؍&8{o���hq�x�����|~���'�:~����w���"�?�[L����[��/0�M�o���-�{@�����VY@|r.O]a~2ou�H���h�Gp#"��EU"k1n�����t#���`���k�>�c�f	�Q�:�ݶ�C�:�7jI nR%�'�+,-�ow2��"c=�tE�#��������4��fG��֬q"k~8�+��$�l��Nz��Bؤ������!x��Z�����9o�� �ᇡ1q0�e�p�L �ч?�K����f�Y�S��>�?q��h�RШ0��FP�����d����{ޒ�g��پ�	&�{4H�d?�P޲��UKL@uv%R`D��G���v�^Ѫ4�w����0��CTxV��o�� 6� ��J����j�Nit<��=]�}�J�B�X{a1yv�L�}A�ե����}�nV������mY��OaN�̦�� �Cд���{U����5�τE�x���A9é�۬-jM�!j�G¼�.��ᚩ�O���ݐj\?̜��8����	-��l����҃���c���G��k��-� Nun�����"(���{c��B��Ț�}��o.�)6H���� �K���,[�V�SX`��=T�����G�S͇��!����]��ϬWuE�㵦�q���|�*㹍���0�@�K3�G�7"}���i��3���l���釷E���=;�(�w�Y���]9��E�Qe��Z�n�|iw� �»��N��w�WT���YR��!4����00��#��:EF�6���(6x��bG���<��#>A���_h�P��{[f����>Fa!�s	n��+���2o~��Xv�#\W�&����̜F'E��Rh)�π!��B	�2���lF�A����91ʿEv^��MQ�������)|:yxr5;�X�.��W��4?�-W�����%O<~�c�R�c�ĥ\�_�wP{ђ�п�D�O�_����+�o�-����/\ז��!�]�%�|���r+���e~�.�b��)Vcg3JûuT-��0m�{k~�o�����{����O5�pm���W^���	��A.l��Kb�^𷞖D$d�P�(�LR�@+jowV���
I氽�X�M�x�,�������>\��ב�Ƭ�]���7"<�\�W|b��a�����E��P�;d����	����GK�Jlvڶ���r�c�ќr���ih��;�bc�ΜV4��-N��M~��>�\Dy�������U��dȋ-"�nB]��p�4����%���[٢�ގ�Bs���u*��^=�����uW��C`��bi�0$��Zu��ཙ8�3kQfe��U��	w�8�D�_SEG߹�W���o؁Gb�ds�� 1E���P�k���cY? �D��l�z��Q���G<Ik����CZV����v�#�� �Y<��Cؖ�Wc�h:oF������}��퐐�Z��Fg�<�k�q�q��� �Q��P�l2��
�D%"���D�+�tt�
\uĕ�������;�oU�,��V�4��� ����v���y, I�QO�M�:֍�t�sy���2�������*��V�r S�A�N.(R�:�>_��\=]�EG�ӮW[�@tK��l��:=�Ô�ė �[���p�����$Cli��C��J�������{�������tɮ�o�~�?��Ęr%B�S�}��H39V�0�p���z�'Fc%K}�,A��W���Z��wb�ܮ�Fa�i�}����E�`��ù>@ȋ��Չ��.��8�]̯��8��e��_���"P�      %   �   x�u�Kn1��)z��c0g�:'���F�����Tz|�����>��	Nx2���/�T�����#�o6��ZX8�omw��ߣ�|�[�$�p�ʸ�]�n� �+�Y{��M�u{�eA�Vڒ�����t����^�'O�ZB��kl�f�x>���|턦��r$�K[}�}�5��5m��J4���;u�W�:M�vT�{�����,�_�H:wl��P�v���]�����      !   �   x����
�0����)����I�\vn��tS�łi��o]�(d���!u� `d]�-����`���Ȯ���пE'4��x��%׮@�,*�^����'Q�h`;4���k�'zǯ��	���qߟ���?/H4�ȹ4�/�R�as��4.����y�H�J�U�����/Rr            x�3�tL����2�t,-��/����� D��         &  x���Mo�@���+<pk\fw�NU�F�bj-1iVE���������I=4Mz�w�fO� ��+%hR�~v�����b��J�R�P���Z1̺�9;�8{~�K�} �Yq��̎�;�ǎ��$R"
T���^!�dԬq\B��L��/��<:�
E5�<�f�G�ʐ��n���!�xڟ���]�C+#�5���ǡ�v�>l7z���^t$ŲkW�Q!���gF��w9��_s>���8����r,F�2^�N{^ߌ���mF���/N��� uq>iEN�s�?_=Ǌ��cᐙ     