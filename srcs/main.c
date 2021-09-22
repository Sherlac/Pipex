/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/09/22 15:50:03 by cmariot           #+#    #+#             */
/*   Updated: 2021/09/22 23:14:26 by cmariot          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex.h"

int	main(int argc, char **argv)
{
//	char	*file1;
//	char	*cmd1;
//	char	*cmd2;
	char	*file2 = argv[1];

	int	stdout_bckp;
	int	fd;

	if (argc != 0)
	{
		//Create a redirection
		stdout_bckp = dup(1);
		fd = open(file2, O_RDWR | O_CREAT);
		if (fd == -1)
		{
			ft_putstr("Error, the file could not be open\n");
			return (-1);
		}
		dup2(fd, 1);
		close(fd);
		
		//Execute the command here
		ft_putstr_fd("Hello World !\n", 1);
	
		//Restore the redirection
		dup2(stdout_bckp, 1);
		close(stdout_bckp);
	}
	return (0);
}
