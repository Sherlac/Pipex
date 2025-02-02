# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/09/30 11:15:47 by cmariot           #+#    #+#              #
#    Updated: 2021/10/05 14:37:48 by cmariot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# **************************************************************************** #
#                          PROJECT'S DIRECTORIES                               #
# **************************************************************************** #

NAME		= pipex
SRCS_DIR	= srcs
INCL_DIR	= includes
LIBFT_DIR	= libft
OBJS_DIR	= objs/


# **************************************************************************** #
#                         COMPILATION AND LINK FLAGS                           #
# **************************************************************************** #

CC					= gcc

CFLAGS				= -Wall -Wextra -Werror
CFLAGS				+= -I $(INCL_DIR)
CFLAGS				+= -I $(LIBFT_DIR)

LFLAGS				= -Wall -Wextra -Werror
LIBFT_A				= -L libft -l ft

# Debug flag, use with 'make DEBUG=1'
ifeq ($(DEBUG), 1)
	CFLAGS			+= -g
endif


# **************************************************************************** #
#                                SOURCE FILES                                  #
# **************************************************************************** #

SRCS		= main.c \
			  mandatory.c \
			  heredoc.c \
			  execute_cmd.c \
			  multi_pipes.c

SRC			:= $(notdir $(SRCS))

OBJ			:= $(SRC:.c=.o)

OBJS		:= $(addprefix $(OBJS_DIR), $(OBJ))

VPATH		:= $(SRCS_DIR) $(OBJS_DIR) $(shell find $(SRCS_DIR) -type d)


# **************************************************************************** #
#									COLORS                                     #
# **************************************************************************** #

GR	= \033[32;1m
RE	= \033[31;1m
YE	= \033[33;1m
CY	= \033[36;1m
RC	= \033[0m


# **************************************************************************** #
#                             MAKEFILE'S RULES                                 #
# **************************************************************************** #

all : $(NAME)

header :
		@printf "        _\n  _ __ (_)_ __   _____  __\n | '_ \| | '_ \ / _ \ \/ /\n | |_) | | |_) |  __/>  <\n | .__/|_| .__/ \___/_/\_\ \n |_|     |_|\n\n"

# Compiling
$(OBJS_DIR)%.o : %.c
		@mkdir -p $(OBJS_DIR)
		@$(CC) $(CFLAGS) -c $< -o $@
		@printf "$(YE)$(CC) $(CFLAGS) -c $< -o $@ ✅ \n$(RC)"

libft_compil:
		@printf "$(YE)Libft compilation ... "
		@make -C libft
		@printf "Success !$(RC)\n\n"

srcs_compil :
		@printf "$(YE)Source code compilation ... \n$(RC)"
			
# Linking
$(NAME)	: header libft_compil srcs_compil $(SRCS) $(OBJS)
		@printf "$(YE)$(NAME) compilation success !\n\n$(RC)"
		@printf "$(GR)Object files linking ...\n$(CC) $(LFLAGS) $(OBJS) $(RC)\n"
		@$(CC) $(LFLAGS) $(OBJS) $(LIBFT_A) -o $(NAME)
		@printf "$(GR)Success !\n$(NAME) is ready.\n\n$(RC)"
		@printf "Usage :\n./pipex file1 'cmd1' 'cmd2' file2\n"
		@printf "./pipex here_doc limiter 'cmd1' 'cmd2' file2\n"
		@printf "./pipex file1 'cmd1' 'cmd2' ... 'cmdN' file2\n\n"

bonus : $(NAME)

# Check 42 norm 
norm :
				@norminette

test:			${NAME}
				@cp Makefile file1
				./pipex file1 "grep .c" "wc -l" file2

bonus_test1:	${NAME}
				./pipex here_doc stop "grep e" "wc -l" file2

bonus_test2:	${NAME}
				@cp Makefile file1
				./pipex file1 "grep SRC" "grep S" "wc -l" file2

# Remove object files
clean :
		@printf "$(RE)Removing $(OBJS_DIR) ... "
		@rm -rf $(OBJS_DIR)
		@printf "Done\n"
		@printf "Cleaning libft ... "
		@make clean -C libft
		@printf "Done$(RC)\n"

# Remove object and binary files
fclean : clean
		@printf "$(RE)Removing $(NAME) ... "
		@rm -f $(NAME)
		@printf "Done\n"
		@printf "Removing libft.a ... "
		@make fclean -C libft
		@printf "Done$(RC)\n"

# Remove all and recompile
re :	 fclean all

.PHONY : clean fclean
